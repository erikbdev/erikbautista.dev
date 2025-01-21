import ActivityClient
import CasePaths
import Foundation
import URLRouting

public extension SiteRoute {
  @CasePathable
  enum APIRoute: Sendable, Equatable {
    case activity(ActivityRoute)
  }
}

public extension SiteRoute.APIRoute {
  @CasePathable
  enum ActivityRoute: Sendable, Equatable {
    case all
    case location(ActivityClient.Location?)
    case nowPlaying(ActivityClient.NowPlaying?)
  }
}

extension SiteRoute.APIRoute {
  struct Router: Sendable, ParserPrinter {
    var body: some URLRouting.Router<SiteRoute.APIRoute> {
      OneOf {
        Route(.case(SiteRoute.APIRoute.activity)) {
          Path { "activity" }

          OneOf {
            Route(.case(SiteRoute.APIRoute.ActivityRoute.all))

            Route(.case(SiteRoute.APIRoute.ActivityRoute.location)) {
              Method.post
              Path { "location" }
              Body(.json(ActivityClient.Location?.self))
            }

            Route(.case(SiteRoute.APIRoute.ActivityRoute.nowPlaying)) {
              Method.post
              Path { "now-playing" }
              Body(.json(ActivityClient.NowPlaying?.self))
            }
          }
        }
      }
    }
  }
}
