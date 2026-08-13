import gleam/option
import lustre/element
import lustre/element/html as h
import server/middleware
import wisp.{type Request, type Response}

pub fn home(req: Request) -> Response {
  h.div([], [h.h1([], [h.text("Hello, world!")])])
  |> element.to_document_string()
  |> wisp.html_response(200)
}

pub fn greeting(req: Request, name: option.Option(String)) -> Response {
  h.div([], [
    h.h1([], [h.text("Hello, " <> option.unwrap(name, "unknown") <> "!")]),
  ])
  |> element.to_document_string()
  |> wisp.html_response(200)
}

pub fn json_greeting(req: Request, name: String) -> Response {
  wisp.json_response(
    "{ \"greeting\": \"hello\", \"name\": \"" <> name <> "\" }",
    200,
  )
}
