import envoy
import gleam/erlang/process
import gleam/int
import gleam/result
import mist
import server/router
import wisp
import wisp/wisp_mist

pub fn main() {
  wisp.configure_logger()

  let secret = envoy.get("SECRET_KEY") |> result.unwrap(wisp.random_string(64))
  let host = envoy.get("ADDRESS") |> result.unwrap("127.0.0.1")
  let port = envoy.get("PORT") |> result.try(int.parse) |> result.unwrap(8000)

  let assert Ok(_) =
    wisp_mist.handler(router.route, secret)
    |> mist.new
    |> mist.bind(host)
    |> mist.port(port)
    |> mist.start

  process.sleep_forever()
}
