defmodule WeatherGovAppTest do
  use ExUnit.Case

  alias WeatherGov.App, as: App
  alias WeatherGov.WeatherInfo, as: WeatherInfo

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

    :meck.unload(IO)
    :meck.unload(System)
  end

  test "main() calls WeatherInfo when valid arg is passed" do
    :meck.new(WeatherInfo)

    :meck.expect(WeatherInfo, :get_info, fn (argv) -> end)

    App.main(["foobar"])

    assert :meck.called(WeatherInfo, :get_info, ["foobar"])

    :meck.unload(WeatherInfo)
  end

end
