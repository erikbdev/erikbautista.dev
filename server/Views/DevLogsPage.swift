import Elementary
import Hummingbird
import HummingbirdElementary
import URLRouting

struct DevLogsPage: HTML {
  var body: some HTML {
    Layout(pageTitle: "dev-logs") {
      BlockSection {
        p { "Coming Soon" }
      }
    }
  }
}

extension DevLogsPage: PageResponder {
  static func response(for route: Void, request: Request, context: some RequestContext) async throws -> any ResponseGenerator {
    HTMLResponse { DevLogsPage() }
  }
}

extension DevLogsPage {
  struct Router: Sendable, ParserPrinter {
    init() {}

    var body: some URLRouting.Router<Void> {
      Path { "dev-logs" }
    }
  }
}
