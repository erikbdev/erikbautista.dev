import CasePaths
import Foundation
import Models
import URLRouting

@CasePathable
public enum SiteRoute: Sendable, Equatable {
  case home
  case robots
  case projects(project: Project? = nil)

  public static let index = Self.home
}

extension SiteRoute {
  public struct Router: Sendable, ParserPrinter {
    public init() {}

    public var body: some URLRouting.Router<SiteRoute> {
      OneOf {
        Route(.case(SiteRoute.home))

        Route(.case(SiteRoute.robots)) {
          Path { "robots.txt" }
        }

        Route(.case(SiteRoute.projects)) {
          Path { "projects" }

          Optionally {
            Path { Parse(.string.representing(Project.self)) }
          }
        }
      }
    }
  }
}
