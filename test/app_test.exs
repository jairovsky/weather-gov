defmodule WeatherGovAppTest do
  use ExUnit.Case

  alias WeatherGov.App, as: App
  alias WeatherGov.Client, as: Client

  test "main() halts when invalid arguments are passed" do
    :meck.new(IO)
    :meck.new(System)

    :meck.expect \
      IO,
      :puts,
      fn ("ERROR:\n\nusage: weather_gov STATION_CODE\n") -> end

    :meck.expect \
      System,
      :halt,
      fn (:abort) -> end

    App.main(["foo", "bar"])

    assert :meck.validate(IO)
    assert :meck.validate(System)

    :meck.unload(IO)
    :meck.unload(System)
  end

  test "main() calls process_arg when valid argument is passed" do
    :meck.new(App)
    :meck.new(Client)

    :meck.expect(App, :main, fn(argv) -> :meck.passthrough([argv]) end)
    :meck.expect(App, :process_arg, fn("foo") -> end)
    :meck.expect(Client, :fetch, fn (_) -> end)

    App.main(["foo"])

    assert :meck.validate(App)
    assert :meck.validate(Client)

    :meck.unload(App)
    :meck.unload(Client)
  end

  test "process_arg() fetches XML through Client" do
    :meck.new(Client)
    :meck.expect(Client, :fetch, fn ("foobar") -> "fake_payload" end)

    assert "fake_payload" == App.process_arg("foobar")

    assert :meck.validate(Client)

    :meck.unload(Client)
  end
end
