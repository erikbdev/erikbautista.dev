import ActivityClient
import Dependencies
import class Foundation.JSONEncoder
import Hummingbird
import HummingbirdRouter
import Pages
import Routes

struct SiteMiddleware<Context: RequestContext>: RouterController {
  @Dependency(\.siteRouter) private var siteRouter
  @Dependency(\.activityClient) private var activityClient
  @Dependency(\.publicAssets) private var publicAssets

  var body: some RouterMiddleware<Context> {
    #if DEBUG
      ReloadBrowserMiddleware()
    #endif

    FileMiddleware(
      "Public", 
      urlBasePath: publicAssets.basePath, 
      searchForIndexHtml: false
    )

    URLRoutingMiddleware(self.siteRouter) { req, ctx, route in
      try withDependencies {
        $0.currentRoute = route
      } operation: {
        switch route {
        case .robots:
          return ""
        case .home:
          return HomePage()
        case .api(.activity(.all)):
        do {
          return try JSONEncoder().encode(self.activityClient.activity(), from: req, context: ctx)
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