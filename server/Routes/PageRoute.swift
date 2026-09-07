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
    public typealias BaseRoute = ServerRoute.PageRoute

    public init() {}

    public var body: some URLRouting.Router<BaseRoute> {
      OneOf {
        Route(.case(\BaseRoute.Cases.index)) {
          OneOf {
            Route(.case(\BaseRoute.IndexComponent?.Cases.some)) {
              Route(.case(\.activity) as AnyCasePath<BaseRoute.IndexComponent, Void>) {
                Path { "activity" }
              }
            }
            Route(.case(\BaseRoute.IndexComponent?.Cases.none))
          }
        }
        Route(.case(\BaseRoute.Cases.devLogs)) {
          Path { "dev-logs" }
        }
        Route(.case(\BaseRoute.Cases.showcase)) {
          Path { "showcase" }
        }
      }
    }
  }
}
