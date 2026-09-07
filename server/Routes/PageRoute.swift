import CasePaths
import URLRouting

extension ServerRoute {
  @CasePathable
  public enum PageRoute: Sendable, Equatable {
    case index(IndexRoute? = nil)
    case devLogs
    case showcase

    public static let index = PageRoute.index()
  }
}

extension ServerRoute.PageRoute {
  @CasePathable
  public enum IndexRoute: Sendable, Equatable {
    case components(IndexComponentRoute)

    @CasePathable
    public enum IndexComponentRoute: Sendable, Equatable {
      case activity
    }
  }
}

extension ServerRoute.PageRoute {
  public struct Router: Sendable, ParserPrinter {
    public typealias BaseRoute = ServerRoute.PageRoute

    public init() {}

    public var body: some URLRouting.Router<BaseRoute> {
      OneOf {
        Route(.case(\.index) as AnyCasePath<BaseRoute, BaseRoute.IndexRoute?>) {
          OneOf {
            Route(.case(\.some) as AnyCasePath<BaseRoute.IndexRoute?, BaseRoute.IndexRoute>) {
              Route(.case(\.components) as AnyCasePath<BaseRoute.IndexRoute, BaseRoute.IndexRoute.IndexComponentRoute>) {
                Path { "components" }
                Route(.case(\.activity) as AnyCasePath<BaseRoute.IndexRoute.IndexComponentRoute, Void>) {
                  Path { "activity" }
                }
              }
            }
            Route(.case(\.none) as AnyCasePath<BaseRoute.IndexRoute?, Void>)
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
