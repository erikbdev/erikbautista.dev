import CasePaths
import Foundation
import URLRouting

@CasePathable
enum ServerRoute: Sendable, Equatable {
  case api(APIRoute)
  case page(PageRoute)
}

extension ServerRoute {
  struct Router: Sendable, ParserPrinter {
    init() {}

    var body: some URLRouting.Router<ServerRoute> {
      OneOf {
        Route(.case(\ServerRoute.Cases.api)) {
          Path { "api" }
          APIRoute.Router()
        }
        Route(.case(\ServerRoute.Cases.page)) {
          PageRoute.Router()
        }
      }
    }
  }
}