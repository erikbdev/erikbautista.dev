import Elementary
import Hummingbird
import HummingbirdElementary

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
  static func response(request: Request, context: some RequestContext) async throws -> any ResponseGenerator {
    HTMLResponse { DevLogsPage() }
  }
}
