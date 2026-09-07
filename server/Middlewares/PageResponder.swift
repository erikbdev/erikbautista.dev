import Hummingbird

protocol PageResponder<SubRoute> {
  associatedtype SubRoute

  static func response(
    for route: SubRoute,
    request: Request,
    context: some RequestContext
  ) async throws -> any ResponseGenerator
}
