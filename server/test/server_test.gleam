import gleam/http
import gleam/list
import gleam/string
import gleeunit
import server/router
import wisp/simulate

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn hello_world_test() {
  let request = simulate.browser_request(http.Get, "/")
  let response = router.route(request)

  assert response.status == 200

  assert response.headers == [#("content-type", "text/html; charset=utf-8")]

  assert simulate.read_body(response)
    |> string.contains("<h1 id=\"greeting\">Hello, world!</h1>")
}

pub fn hello_test() {
  let request = simulate.browser_request(http.Get, "/hello")
  let response = router.route(request)

  assert response.status == 200

  assert response.headers
    == [#("content-type", "text/event-stream"), #("cache-control", "no-cache")]

  assert simulate.read_body(response)
    == "event: datastar-patch-elements\ndata: elements <h1 id=\"greeting\">Hello, unknown!</h1>\n\n"
}

pub fn hello_john_test() {
  let request = simulate.browser_request(http.Get, "/hello/john")
  let response = router.route(request)

  assert response.status == 200

  assert response.headers
    == [#("content-type", "text/event-stream"), #("cache-control", "no-cache")]

  assert simulate.read_body(response)
    == "event: datastar-patch-elements\ndata: elements <h1 id=\"greeting\">Hello, john!</h1>\n\n"
}

pub fn get_javascript_test() {
  let request = simulate.browser_request(http.Get, "/static/datastar.js")
  let response = router.route(request)

  assert response.status == 200

  assert list.key_find(response.headers, "content-type")
    == Ok("text/javascript; charset=utf-8")
}
