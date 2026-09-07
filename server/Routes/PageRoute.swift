import CasePaths
import URLRouting

extension ServerRoute {
  @CasePathable
  enum PageRoute: Sendable, Equatable {
    case index(IndexRoute?)
    case devLogs
    case showcase
  }
}

extension ServerRoute.PageRoute {
  struct Router: Sendable, ParserPrinter {
    typealias BaseRoute = ServerRoute.PageRoute

    init() {}

    var body: some URLRouting.Router<BaseRoute> {
      OneOf {
        Route(.case(\BaseRoute.Cases.index)) {
          IndexRoute.Router()
        }
        Route(.case(\BaseRoute.Cases.devLogs)) {
          DevLogsPage.Router()
        }
        Route(.case(\BaseRoute.Cases.showcase)) {
          ShowcasePage.Router()
        }
      }
    }
  }
}
