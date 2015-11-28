defmodule WeatherGov.Client do
  import HTTPoison
  import WeatherGov.UriFormatter

  def fetch(station_code) do
    station_code
    |> format
    |> get
    |> validate
  end

  defp validate({:ok, %{status_code: 200, body: payload}}), do: payload
  defp validate({:error, reason}) do
    IO.puts """
    HTTP request error.
    Details: #{reason}.
    Exiting...
    """
    System.halt(:abort)
  end
end