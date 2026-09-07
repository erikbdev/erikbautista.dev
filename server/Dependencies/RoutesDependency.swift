import Dependencies

extension ServerRoute: DependencyKey {
  static let liveValue: ServerRoute = .page(.index(nil))
}

extension ServerRoute.Router: DependencyKey {
  static let liveValue = Self()
}

extension DependencyValues {
  var serverRouter: ServerRoute.Router {
    get { self[ServerRoute.Router.self] }
    set { self[ServerRoute.Router.self] = newValue }
  }

  var currentRoute: ServerRoute {
    get { self[ServerRoute.self] }
    set { self[ServerRoute.self] = newValue }
  }
}