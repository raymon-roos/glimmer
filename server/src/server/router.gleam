import gleam/option
import server/handler
import server/middleware
import wisp.{type Request, type Response}

pub fn route(req: Request) -> Response {
  use req <- middleware.middleware(req)

  case wisp.path_segments(req) {
    [] -> handler.home(req)

    ["hello"] -> handler.greeting(req, option.None)
    ["hello", name] -> handler.greeting(req, option.Some(name))

    _ -> wisp.not_found()
  }
}
