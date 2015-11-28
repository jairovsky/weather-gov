defmodule WeatherGov.CommandLineParser do
  def parse_args(argv) do
    case argv do
      [station_code] -> {:ok, station_code}
      _ -> {:error, "usage: weather_gov STATION_CODE"}
    end
  end
end