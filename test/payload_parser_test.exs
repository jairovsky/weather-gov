defmodule WeatherGovPayloadParserTest do
  use ExUnit.Case

  alias WeatherGov.PayloadParser, as: PayloadParser

  test "parse() converts a XML string into a map structure" do
    assert %{
      credit: "NOAA's National Weather Service",
      credit_url: "http://weather.gov/",
      location: "Denton Municipal Airport, TX"
    } == PayloadParser.parse(xml_fixture)
  end

  defp xml_fixture do
    "#{__DIR__}/fixtures/payload.xml"
    |> File.read!
  end
end