import CasePaths
import Foundation
import URLRouting

@CasePathable
public enum ServerRoute: Sendable, Equatable {
  case api(APIRoute)
  case page(SiteRoute)
}

extension ServerRoute {
  public struct Router: Sendable, ParserPrinter {
    public init() {}

    public var body: some URLRouting.Router<ServerRoute> {
      OneOf {
        Route(.case(\ServerRoute.Cases.api)) {
          Path { "api" }
          APIRoute.Router()
        }
        Route(.case(\ServerRoute.Cases.page)) {
          SiteRoute.Router()
        }
      }
    }
  }
}