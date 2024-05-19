import VercelMacros
import VercelRuntime

@main
@Routable
struct App {
  var routes: [Route.Type] = [
    IndexRoute.self,
    FooRoute.self
  ]
}