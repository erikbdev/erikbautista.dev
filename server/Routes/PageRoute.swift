import CasePaths
import URLRouting

extension ServerRoute {
  @CasePathable
  public enum PageRoute: Sendable, Equatable {
    case index(IndexComponent? = nil)
    case devLogs
    case showcase

    public static let index = PageRoute.index()
  }
}

extension ServerRoute.PageRoute {
  @CasePathable
  public enum IndexComponent: Sendable, Equatable {
    case activity
  }
}

extension ServerRoute.PageRoute {
  public struct Router: Sendable, ParserPrinter {
    public init() {}

    public var body: some URLRouting.Router<ServerRoute.PageRoute> {
      OneOf {
        Route(.case(\ServerRoute.PageRoute.Cases.index)) {
          OneOf {
            Route(.case(\ServerRoute.PageRoute.IndexComponent?.Cases.some)) {
              Route(.case(\.activity) as AnyCasePath<ServerRoute.PageRoute.IndexComponent, Void>) {
                Path { "activity" }
              }
            }
            Route(.case(\ServerRoute.PageRoute.IndexComponent?.Cases.none))
          }
        }
        Route(.case(\ServerRoute.PageRoute.Cases.devLogs)) {
          Path { "dev-logs" }
        }
        Route(.case(\ServerRoute.PageRoute.Cases.showcase)) {
          Path { "showcase" }
        }
      }
    }
  }
}
