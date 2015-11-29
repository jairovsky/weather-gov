defmodule WeatherGovWeatherInfoTest do
  use ExUnit.Case

  alias WeatherGov.WeatherInfo, as: WeatherInfo
  alias WeatherGov.Client, as: Client
  alias WeatherGov.PayloadParser, as: PayloadParser
  alias WeatherGov.DisplayFormatter, as: DisplayFormatter

  test """
  process_arg()
    fetches XML through Client
    parses XML through PayloadParser
    formats data through DisplayFormatter
    prints formatted data
  """ do
    :meck.new(Client)
    :meck.new(PayloadParser)
    :meck.new(DisplayFormatter)
    :meck.new(IO)

    :meck.expect(Client, :fetch, fn ("foobar") -> "fake_payload" end)
    :meck.expect(PayloadParser, :parse, fn ("fake_payload") -> %{fake: "data"} end)
    :meck.expect(DisplayFormatter, :format, fn (%{fake: "data"}) -> "fake_formatted" end)
    :meck.expect(IO, :puts, fn (str) -> end)

    WeatherInfo.get_info("foobar")

    assert :meck.called(IO, :puts, ["fake_formatted"])

    :meck.unload(Client)
    :meck.unload(PayloadParser)
    :meck.unload(DisplayFormatter)
    :meck.unload(IO)
  end
end