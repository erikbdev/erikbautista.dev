import Dependencies

extension SiteRoute.Router: DependencyKey {
  public static let liveValue = Self()
}

private enum CurrentRouteKey: DependencyKey {
  static let liveValue = SiteRoute.home
}

public extension DependencyValues {
  var siteRouter: SiteRoute.Router {
    get { self[SiteRoute.Router.self] }
    set { self[SiteRoute.Router.self] = newValue }
  }

  var currentRoute: SiteRoute {
    get { self[CurrentRouteKey.self] }
    set { self[CurrentRouteKey.self] = newValue }
  }
}
