import Elementary
import Hummingbird
import HummingbirdElementary

struct ShowcasePage: HTML {
  var body: some HTML {
    Layout(pageTitle: "showcase") {
      BlockSection {
        p { "Coming Soon" }
      }
    }
  }
}

extension ShowcasePage: PageResponder {
  static func response(for route: Void, request: Request, context: some RequestContext) async throws -> any ResponseGenerator {
    HTMLResponse { ShowcasePage() }
  }
}
