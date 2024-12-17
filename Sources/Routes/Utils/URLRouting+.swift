import Foundation
import Hummingbird
import HummingbirdRouter
@preconcurrency import URLRouting

public struct RoutingMiddleware<
  Context: RequestContext,
  Router: Parser
>: @unchecked Sendable, RouterMiddleware where Router.Input == URLRequestData {
  private let router: Router
  private let respond: (Self.Input, Context, Router.Output) async throws -> ResponseGenerator

  public init(
    _ router: Router,
    use closure: @escaping @Sendable (Self.Input, Context, Router.Output) async throws -> ResponseGenerator
  ) {
    self.router = router
    self.respond = closure
  }

  public func handle(
    _ input: Self.Input,
    context: Context,
    next: (Self.Input, Context) async throws -> Self.Output
  ) async throws -> Self.Output {
    guard let data = await URLRequestData(request: input) else {
      return try await next(input, context)
    }

    do {
      let route = try self.router.parse(data)
      return try await self.respond(input, context, route).response(from: input, context: context)
    } catch let routingError {
      return try await next(input, context)
    }

    return try await next(input, context)
  }
}

private extension URLRequestData {
  init?(request: Request) async {
    guard let url = URL(string: request.uri.string),
          let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
    else {
      return nil
    }

    var body: ByteBuffer? = ByteBuffer()

    do {
      for try await buffer in request.body {
        var buffer = buffer
        body?.writeBuffer(&buffer)
      }
    } catch {
      body = nil
    }

    self.init(
      method: request.method.rawValue,
      scheme: request.uri.scheme?.rawValue,
      // user: request.headers[.authorization],
      // password: request.headers[.authorization],
      host: request.uri.host,
      port: request.uri.port,
      path: request.uri.path,
      query: (components.queryItems ?? []).reduce(into: [:]) { query, item in
        query[item.name, default: []].append(item.value)
      },
      // headers: .init(
      // request.headers.map { key, value in
      // (key, value.split(separator: ",", omittingEmptySubsequences: false).map { String($0) })
      // },
      // uniquingKeysWith: { $0 + $1 }
      // ),
      body: body.flatMap { Data(buffer: $0) }
    )
  }
}
