import ArgumentParser
import Dependencies
import Hummingbird
import HummingbirdRouter
import Logging
import Pages
import Routes

@main
struct Portfolio: AsyncParsableCommand {
  @Option(name: .long)
  var env: AppEnv = .development

  @Option(name: .shortAndLong)
  var hostname = "127.0.0.1"

  @Option(name: .shortAndLong)
  var port = 8080

  func run() async throws {
    try await withDependencies { _ in
      // TODO: add other dependencies if needed
    } operation: {
      let logger = Logger(label: "server")
      logger.info("Running server in '\(env)' mode")

      let app = self.buildApp(logger)
      try await app.runService()
    }
  }

  func buildApp(_ logger: Logger = Logger(label: "portfolio")) -> some ApplicationProtocol {
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
