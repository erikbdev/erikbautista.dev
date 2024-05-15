import VercelMacros
import VercelRuntime

@Routable
struct App {
  var routes: [Route.Type] = [
    IndexRoute.self
  ]
}