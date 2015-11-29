defmodule WeatherGovPayloadParserTest do
  use ExUnit.Case

  alias WeatherGov.PayloadParser, as: PayloadParser

  test "parse() converts a XML string into a map structure" do
    assert %{
      credit: "NOAA's National Weather Service",
      credit_url: "http://weather.gov/",
      location: "Denton Municipal Airport, TX",
      observation_time: "Last Updated on Nov 28 2015, 5:53 pm CST",
      weather: "Overcast",
      temperature_string: "39.0 F (3.9 C)"
    } == PayloadParser.parse(xml_fixture)
  end

  defp xml_fixture do
    "#{__DIR__}/fixtures/payload.xml"
    |> File.read!
  end
end