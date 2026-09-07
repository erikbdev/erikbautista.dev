import CasePaths
import Foundation
import Shared
import URLRouting

extension ServerRoute {
  @CasePathable
  public enum APIRoute: Sendable, Equatable {
    case activity(ActivityRoute)

    #if DEBUG
      case liveReload(build: String)
    #endif
  }
}

extension ServerRoute.APIRoute {
  @CasePathable
  public enum ActivityRoute: Sendable, Equatable {
    case all
    case location(Activity.Location?)
    case nowPlaying(Activity.NowPlaying?)
  }
}

extension ServerRoute.APIRoute {
  public struct Router: Sendable, ParserPrinter {
    public var body: some URLRouting.Router<ServerRoute.APIRoute> {
      OneOf {
        Route(.case(\.activity) as AnyCasePath<ServerRoute.APIRoute, ServerRoute.APIRoute.ActivityRoute>) {
          Path { "activity" }

          OneOf {
            Route(.case(ServerRoute.APIRoute.ActivityRoute.all))

            Route(.case(\ServerRoute.APIRoute.ActivityRoute.Cases.location)) {
              Method.post
              Path { "location" }
              Optionally {
                Body(.json(Activity.Location.self, decoder: Activity.decoder, encoder: Activity.encoder))
              }
            }

            Route(.case(\ServerRoute.APIRoute.ActivityRoute.Cases.nowPlaying)) {
              Method.post
              Path { "now-playing" }
              Optionally {
                Body(.json(Activity.NowPlaying.self, decoder: Activity.decoder, encoder: Activity.encoder))
              }
            }
          }
        }

        #if DEBUG
          Route(.case(\ServerRoute.APIRoute.Cases.liveReload)) {
            Method.get
            Path { "live-reload" }
            Query {
              Field("tag", .string)
            }
          }
        #endif
      }
    }
  }
}
