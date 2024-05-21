// import VercelMacros
// import VercelRuntime
import Vercel

@main
// @Routable
struct App: ExpressHandler {
  static var basePath = "/api"
    static func configure(router: isolated Router) async throws {
      router.get("/") { req, res in
        res.status(.ok).send("Hello, Swift")
      }
    }
}