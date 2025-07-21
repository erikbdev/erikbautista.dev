import ActivityClient
import Dependencies
import Hummingbird
import HummingbirdRouter
import HummingbirdURLRouting
import MiddlewareUtils
import Pages
import PublicAssets
import Routes

import class Foundation.JSONEncoder

struct SiteMiddleware<Context: RequestContext>: RouterController {
  @Dependency(\.siteRouter) private var siteRouter
  @Dependency(\.activityClient) private var activityClient
  @Dependency(\.publicAssets) private var publicAssets

  var body: some RouterMiddleware<Context> {
    #if DEBUG
      LiveReloadMiddleware()
    #endif

    NotFoundMiddleware()

    if self.publicAssets.baseURL.isFileURL {
      FileMiddleware(
        self.publicAssets.baseURL.path(),
        searchForIndexHtml: false
      )
    }

    URLRoutingMiddleware(self.siteRouter) { req, ctx, route in
      try withDependencies {
        $0.currentRoute = route
      } operation: {
        switch route {
        case .home:
          return HomePage(codeLang: .resolve(req))
        case .api(.activity(.all)):
          do {
            return try JSONEncoder().encode(self.activityClient.redactedActivity(), from: req, context: ctx)
          } catch {
            throw HTTPError(.forbidden)
          }
        case let .api(.activity(.location(location))):
          guard let auth = req.headers.authorization else {
            throw HTTPError(.notFound)
          }
          try auth.validate()
          self.activityClient.updateLocation(location)
          return Response(status: .ok)
        case let .api(.activity(.nowPlaying(nowPlaying))):
          guard let auth = req.headers.authorization else {
            throw HTTPError(.notFound)
          }
          try auth.validate()
          self.activityClient.updateNowPlaying(nowPlaying)
          return Response(status: .ok)
        }
      }
    }
  }
}

private struct NotFoundMiddleware<Context: RequestContext>: RouterMiddleware {
  func handle(
    _ input: Request,
    context: Context,
    next: (Request, Context) async throws -> Response
  ) async throws -> Response {
    do {
      return try await next(input, context)
    } catch let error as HTTPError {
      guard error.status == .notFound else {
        throw error
      }

      return try NotFoundPage(codeLang: .resolve(input))
        .response(from: input, context: context, status: .notFound)
    }
  }
}

extension CodeLang {
  fileprivate static func resolve(_ req: Request) -> CodeLang? {
    req.uri.queryParameters["codeLang"]
      .flatMap {
        $0 == "markdown" || $0 == "md"
          ? nil
          : CodeLang(rawValue: $0.trimmingCharacters(in: .whitespacesAndNewlines).lowercased())
      }
  }
}
