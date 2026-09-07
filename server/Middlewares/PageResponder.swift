import Hummingbird

protocol PageResponder {
  associatedtype Route: Sendable = Void

  static func response(
    for route: Route,
    request: Request,
    context: some RequestContext
  ) async throws -> any ResponseGenerator
}

extension PageResponder where Route == Void {
  static func response(
    for route: Void,
    request: Request,
    context: some RequestContext
  ) async throws -> any ResponseGenerator {
    try await response(request: request, context: context)
  }

  static func response(request: Request, context: some RequestContext) async throws -> any ResponseGenerator {
    fatalError("\(Self.self) must implement response(request:context:)")
  }
}
