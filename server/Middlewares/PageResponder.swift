import Hummingbird

protocol PageResponder<Route> {
  associatedtype Route

  static func response(
    for route: Route,
    request: Request,
    context: some RequestContext
  ) async throws -> any ResponseGenerator
}
