import CasePaths
import Foundation
import URLRouting
import ActivityClient

extension SiteRoute {
  @CasePathable
  public enum APIRoute: Sendable, Equatable {
    case location(ActivityClient.Location?)
    case nowPlaying(ActivityClient.NowPlaying?)
  }
}

extension SiteRoute.APIRoute {
  struct Router: Sendable, ParserPrinter {
    var body: some URLRouting.Router<SiteRoute.APIRoute> {
      OneOf {
        Route(.case(SiteRoute.APIRoute.location)) {
          Method.post
          Path { "activity"; "location" }
          Body(.json(ActivityClient.Location?.self))
        }

        Route(.case(SiteRoute.APIRoute.nowPlaying)) {
          Method.post
          Path { "activity"; "now-playing" }
          Body(.json(ActivityClient.NowPlaying?.self))
        }
      }
    }
  }
}