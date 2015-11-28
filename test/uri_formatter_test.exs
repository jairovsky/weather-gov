defmodule WeatherGovUriFormatterTest do
  use ExUnit.Case

  alias WeatherGov.UriFormatter, as: UF

  test "format() returns API URI with station code" do
    assert "http://w1.weather.gov/xml/current_obs/KDEN.xml" \
           == UF.format("KDEN")
  end

  test "format() returns API URI with upcased station code" do
    assert "http://w1.weather.gov/xml/current_obs/KDEN.xml" \
           == UF.format("kden")
  end
end
