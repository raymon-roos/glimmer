import gleam/json
import gleam/option
import lustre/element
import lustre/element/html as h
import wisp.{type Request, type Response}

pub fn home(_req: Request) -> Response {
  h.div([], [h.h1([], [h.text("Hello, world!")])])
  |> element.to_document_string()
  |> wisp.html_response(200)
}

pub fn greeting(_req: Request, name: option.Option(String)) -> Response {
  h.div([], [
    h.h1([], [h.text("Hello, " <> option.unwrap(name, "unknown") <> "!")]),
  ])
  |> element.to_document_string()
  |> wisp.html_response(200)
}

pub fn json_greeting(_req: Request, name: String) -> Response {
  json.object([
    #("greeting", json.string("hello")),
    #("name", json.string(name)),
  ])
  |> json.to_string
  |> wisp.json_response(200)
}
