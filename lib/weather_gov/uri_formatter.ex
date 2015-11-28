defmodule WeatherGov.UriFormatter do
  import ExPrintf

  def format(station_code) do
    sprintf(
      Application.get_env(:weather_gov, :base_uri),
      [String.upcase(station_code)]
    )
  end
end