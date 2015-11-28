defmodule WeatherGovCommandLineParserTest do
  use ExUnit.Case

  alias WeatherGov.CommandLineParser, as: CLP

  test "args list must have only one element, the weather station code" do
    assert {:ok, "foobar"} == CLP.parse_args(["foobar"])
  end

  test "returns error if list hasn't exactly one element" do
    assert {:error, "usage: weather_gov STATION_CODE"} \
           == CLP.parse_args(["foobar", "asdf"])

    assert {:error, "usage: weather_gov STATION_CODE"} \
           == CLP.parse_args([])
  end
end