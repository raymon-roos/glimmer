import datastar/ds_lustre as ds
import datastar/ds_sse
import datastar/ds_wisp
import gleam/json
import gleam/option
import lustre/attribute as a
import lustre/element
import lustre/element/html as h
import wisp.{type Request, type Response}

pub fn home(_req: Request) -> Response {
  h.div([], [
    h.h1([a.id("greeting")], [h.text("Hello, world!")]),
    h.button([ds.data_on_click("@get('/hello/datastar')")], [h.text("Hi!")]),
  ])
  |> page
  |> element.to_document_string()
  |> wisp.html_response(200)
}

pub fn greeting(_req: Request, name: option.Option(String)) -> Response {
  let events = [
    ds_sse.patch_elements()
    |> ds_sse.patch_elements_elements(
      h.h1([a.id("greeting")], [
        h.text("Hello, " <> option.unwrap(name, "unknown") <> "!"),
      ])
      |> element.to_string(),
    )
    |> ds_sse.patch_elements_end(),
  ]

  wisp.ok() |> ds_wisp.send(events)
}

pub fn json_greeting(_req: Request, name: String) -> Response {
  json.object([
    #("greeting", json.string("hello")),
    #("name", json.string(name)),
  ])
  |> json.to_string
  |> wisp.json_response(200)
}

/// Wrap content in html & head, with references to static assets included
fn page(content: element.Element(a)) -> element.Element(a) {
  h.html([a.lang("en")], [
    h.head([], [
      h.meta([a.charset("UTF-8")]),
      h.meta([
        a.name("viewport"),
        a.content("width=device-width, initial-scale=1"),
      ]),
      h.script([a.type_("module"), a.src("/static/datastar.js")], ""),
    ]),
    h.body([], [
      content,
    ]),
  ])
}
