import ArgumentParser
import Dependencies
import Hummingbird
import HummingbirdRouter
import Logging
import Pages
import Routes

private let logger = Logger(label: "portfolio-server")

@main
struct Portfolio: AsyncParsableCommand {
  @Option(name: .long)
  var env = AppEnv.development

  @Option(name: .shortAndLong)
  var hostname = "127.0.0.1"

  @Option(name: .shortAndLong)
  var port = 8080

  func run() async throws {
    try await withDependencies { deps in
      #if DEBUG
        deps.envVar = try await .dotEnv()
      #endif
    } operation: {
      let app = self.buildApp()
      logger.info("Running server in '\(env.rawValue)' mode")
      try await app.runService()
    }
  }

  func buildApp() -> some ApplicationProtocol {
    @Dependency(\.envVar) var envVar

    let router = Router()
    router.addMiddleware {
      SiteMiddleware()
    }

    return Application(
      router: router,
      configuration: ApplicationConfiguration(
        address: .hostname(self.hostname, port: self.port),
        serverName: "portfolio"
      ),
      logger: logger
    )
  }
}
