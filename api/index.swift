import VercelMacros
import VercelRuntime

@Route
struct IndexRoute {
  func resolve(_ request: Request) async throws -> Response {
    .init()
  }
}