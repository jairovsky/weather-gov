defmodule WeatherGov.App do

  alias WeatherGov.CommandLineParser, as: CLP

  def main(argv) do
    case CLP.parse_args(argv) do
      {:ok, station_code} -> process_arg(station_code)
      {:error, msg} -> handle_error(msg)
    end
  end

  def process_arg(station_code) do
    
  end

  defp handle_error(msg) do
    IO.puts "ERROR:\n\n#{msg}\n"
    System.halt(:abort)
  end
end