import ActivityClient
import Dependencies
import Hummingbird
import HummingbirdRouter
import Pages
import Routes

struct SiteMiddleware<Context: RequestContext>: RouterController {
  @Dependency(\.siteRouter) private var siteRouter
  @Dependency(\.activityClient) private var activityClient

  var body: some RouterMiddleware<Context> {
    #if DEBUG
      ReloadBrowserMiddleware()
    #endif

    FileMiddleware("Public", searchForIndexHtml: false)

    URLRoutingMiddleware(self.siteRouter) { req, ctx, route in
      withDependencies {
        $0.currentRoute = route
      } operation: {
        switch route {
        case .robots:
          return ""
        case .home:
          return HomePage()
        case let .api(.location(location)):
          activityClient.updateLocation(location)
          return Response(status: .ok)
        case let .api(.nowPlaying(nowPlaying)):
          activityClient.updateNowPlaying(nowPlaying)
          return Response(status: .ok)
        }
      }
    }
  }
}
