import ActivityClient
import CasePaths
import Foundation
import URLRouting

extension SiteRoute {
  @CasePathable
  public enum APIRoute: Sendable, Equatable {
    case activity(ActivityRoute)
  }
}

extension SiteRoute.APIRoute {
  @CasePathable
  public enum ActivityRoute: Sendable, Equatable {
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
              Optionally {
                Body(.json(ActivityClient.Location.self, decoder: ActivityClient.Activity.decoder, encoder: ActivityClient.Activity.encoder))
              }
            }

            Route(.case(SiteRoute.APIRoute.ActivityRoute.nowPlaying)) {
              Method.post
              Path { "now-playing" }
              Optionally {
                Body(.json(ActivityClient.NowPlaying.self, decoder: ActivityClient.Activity.decoder, encoder: ActivityClient.Activity.encoder))
              }
            }
          }
        }
      }
    }
  }
}
