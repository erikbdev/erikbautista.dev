import Dependencies
import Hummingbird
import HummingbirdRouter
import Logging
import Pages
import Routes

@main
struct Server {
  let app = {
    @Dependency(\.envVar) var envVar

    let logger = Logger(label: "server")
    logger.info("Running server in '\(envVar.appEnv)' mode")

    let router = Router()
    router.addMiddleware {
      SiteMiddleware()
    }

    var app = Application(
      router: router,
      configuration: ApplicationConfiguration(
        address: .hostname(
          port: envVar.port
        )
      ),
      logger: logger
    )

    #if DEBUG
      app.beforeServerStarts {
        try await tailwind()
      }
    #endif
    return app
  }()

  func callAsFunction() async throws {
    try await self.app.runService()
  }

  static func main() async throws {
    try await withDependencies {
      $0.envVar = try await .dotEnv()
    } operation: {
      let server = Server()
      try await server()
    }
  }
}
