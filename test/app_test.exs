defmodule WeatherGovAppTest do
  use ExUnit.Case

  alias WeatherGov.App, as: App

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
    :meck.expect(App, :main, fn(argv) -> :meck.passthrough([argv]) end)
    :meck.expect(App, :process_arg, fn("foo") -> end)

    App.main(["foo"])

    assert :meck.validate(App)

    :meck.unload(App)
  end
end
