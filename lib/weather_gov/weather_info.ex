defmodule WeatherGov.WeatherInfo do

  alias WeatherGov.Client, as: Client
  alias WeatherGov.PayloadParser, as: PayloadParser
  alias WeatherGov.DisplayFormatter, as: DisplayFormatter

  def get_info(station_code) do
    Client.fetch(station_code)
    |> PayloadParser.parse
    |> DisplayFormatter.format
    |> IO.puts
  end
end