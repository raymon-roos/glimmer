import app/middleware
import gleam/option
import wisp.{type Request, type Response}

pub fn home(req: Request) -> Response {
  use _req <- middleware.middleware(req)

  let body = "<h1>Hello, world!</h1>"

  wisp.html_response(body, 200)
}

pub fn greeting(req: Request, name: option.Option(String)) -> Response {
  use _req <- middleware.middleware(req)

  let body = "<h1>Hello, " <> option.unwrap(name, "unknown") <> "!</h1>"

  wisp.html_response(body, 200)
}
