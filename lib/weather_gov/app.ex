defmodule WeatherGov.App do

  alias WeatherGov.CommandLineParser, as: CLP
  alias WeatherGov.Client, as: Client
  alias WeatherGov.PayloadParser, as: PayloadParser
  alias WeatherGov.DisplayFormatter, as: DisplayFormatter
  alias WeatherGov.WeatherInfo, as: WeatherInfo

  def main(argv) do
    case CLP.parse_args(argv) do
      {:ok, station_code} -> WeatherInfo.get_info(station_code)
      {:error, msg} -> handle_error(msg)
    end
  end

  defp handle_error(msg) do
    IO.puts "ERROR:\n\n#{msg}\n"
    System.halt(:abort)
  end
end