import CasePaths
import URLRouting

extension ServerRoute {
  @CasePathable
  public enum SiteRoute: Sendable, Equatable {
    case index(IndexComponent? = nil)
    case devLogs
    case showcase

    public static let index = SiteRoute.index()
  }
}

extension ServerRoute.SiteRoute {
  @CasePathable
  public enum IndexComponent: Sendable, Equatable {
    case activity
  }
}

extension ServerRoute.SiteRoute {
  public struct Router: Sendable, ParserPrinter {
    public init() {}

    public var body: some URLRouting.Router<ServerRoute.SiteRoute> {
      OneOf {
        Route(.case(\ServerRoute.SiteRoute.Cases.index)) {
          OneOf {
            Route(.case(\ServerRoute.SiteRoute.IndexComponent?.Cases.some)) {
              Route(.case(\.activity) as AnyCasePath<ServerRoute.SiteRoute.IndexComponent, Void>) {
                Path { "activity" }
              }
            }
            Route(.case(\ServerRoute.SiteRoute.IndexComponent?.Cases.none))
          }
        }
        Route(.case(\ServerRoute.SiteRoute.Cases.devLogs)) {
          Path { "dev-logs" }
        }
        Route(.case(\ServerRoute.SiteRoute.Cases.showcase)) {
          Path { "showcase" }
        }
      }
    }
  }
}
