import app/router
import gleam/http
import gleeunit
import wisp/simulate

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn hello_world_test() {
  let request = simulate.browser_request(http.Get, "/")
  let response = router.route(request)

  assert response.status == 200

  assert response.headers == [#("content-type", "text/html; charset=utf-8")]

  assert simulate.read_body(response) == "<h1>Hello, world!</h1>"
}

pub fn hello_test() {
  let request = simulate.browser_request(http.Get, "/hello")
  let response = router.route(request)

  assert response.status == 200

  assert response.headers == [#("content-type", "text/html; charset=utf-8")]

  assert simulate.read_body(response) == "<h1>Hello, unknown!</h1>"
}

pub fn hello_john_test() {
  let request = simulate.browser_request(http.Get, "/hello/john")
  let response = router.route(request)

  assert response.status == 200

  assert response.headers == [#("content-type", "text/html; charset=utf-8")]

  assert simulate.read_body(response) == "<h1>Hello, john!</h1>"
}
