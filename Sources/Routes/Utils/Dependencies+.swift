import Dependencies

extension SiteRoute: DependencyKey {
  public static let liveValue = SiteRoute.home
}

extension SiteRoute.Router: DependencyKey {
  public static let liveValue = Self()
}

public extension DependencyValues {
  var siteRouter: SiteRoute.Router {
    get { self[SiteRoute.Router.self] }
    set { self[SiteRoute.Router.self] = newValue }
  }

  var currentRoute: SiteRoute {
    get { self[SiteRoute.self] }
    set { self[SiteRoute.self] = newValue }
  }
}
