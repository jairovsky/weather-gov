defmodule WeatherGov.DisplayFormatter do
  def format(data) do
    """
    --------------------------------------------------
    #{data[:credit]} (#{data[:credit_url]})
    --------------------------------------------------

    Station:     #{data[:location]}
    Weather:     #{data[:weather]}
    Temperature: #{data[:temperature_string]}

    --------------------------------------------------
    #{data[:observation_time]}

    """
  end
end