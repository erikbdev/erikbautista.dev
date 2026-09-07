import Dependencies

extension ServerRoute: DependencyKey {
  public static let liveValue: ServerRoute = .page(.index(nil))
}

extension ServerRoute.Router: DependencyKey {
  public static let liveValue = Self()
}

extension DependencyValues {
  public var serverRouter: ServerRoute.Router {
    get { self[ServerRoute.Router.self] }
    set { self[ServerRoute.Router.self] = newValue }
  }

  public var currentRoute: ServerRoute {
    get { self[ServerRoute.self] }
    set { self[ServerRoute.self] = newValue }
  }
}