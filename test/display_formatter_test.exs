defmodule WeatherGovDisplayFormatterTest do
  use ExUnit.Case

  alias WeatherGov.DisplayFormatter, as: DF

  test "formats data for pretty print" do
    assert """
    --------------------------------------------------
    NOAA's National Weather Service (http://weather.gov/)
    --------------------------------------------------

    Station:     Denton Municipal Airport, TX
    Weather:     Overcast
    Temperature: 39.0 F (3.9 C)

    --------------------------------------------------
    Last Updated on Nov 28 2015, 5:53 pm CST

    """ == DF.format(%{
      credit: "NOAA's National Weather Service",
      credit_url: "http://weather.gov/",
      location: "Denton Municipal Airport, TX",
      observation_time: "Last Updated on Nov 28 2015, 5:53 pm CST",
      weather: "Overcast",
      temperature_string: "39.0 F (3.9 C)"
    })
  end
end