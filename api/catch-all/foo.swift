import VercelMacros
import VercelRuntime

@Route
struct FooRoute {
  func resolve(_ request: Request) async throws -> Response {
    .ok
  }
}