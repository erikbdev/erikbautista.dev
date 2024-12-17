import Dependencies
import Hummingbird
import HummingbirdRouter
import Logging
import Pages
import Routes

@main
struct Server: RouterController {
  typealias Context = BasicRouterRequestContext

  @Dependency(\.envVar) private var env
  @Dependency(\.siteRouter) private var siteRouter

  var body: some RouterMiddleware<Context> {
    if self.env.appEnv != .production {
      LiveReload()
    }

    RoutingMiddleware(self.siteRouter) { req, ctx, route in
      withDependencies {
        $0.currentRoute = route
      } operation: {
        switch route {
        case .robots: ""
        case .home: HomePage()
        case .projects(.none): Response(status: .notFound)
        case let .projects(.some(project)): ProjectPage(project: project)
        }
      }
    }
  }

  static func main() async throws {
    try await withDependencies {
      $0.envVar = try await .dotEnv()
    } operation: {
      @Dependency(\.envVar) var envVar

      let logger = Logger(label: "server")
      logger.info("Running server in '\(envVar.appEnv.rawValue)' mode")

      let server = Server()
      let router = RouterBuilder(context: Context.self) { server.body }

      let app = Application(
        router: router,
        configuration: .init(address: .hostname(port: envVar.port)),
        logger: logger
      )

      try await app.runService()
    }
  }
}
