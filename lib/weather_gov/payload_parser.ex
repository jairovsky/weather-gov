defmodule WeatherGov.PayloadParser do

  require Record
  use PatternTap

  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText,    from_lib: "xmerl/include/xmerl.hrl")

  def parse(xml_string) do
    xml_string
    |> String.to_char_list
    |> :xmerl_scan.string
    |> to_map
  end

  defp to_map({document, _}) do
    %{
      credit: xpath_text(document, '/credit'),
      credit_url: xpath_text(document, '/credit_URL'),
      location: xpath_text(document, '/location'),
      observation_time: xpath_text(document, '/observation_time'),
      weather: xpath_text(document, '/weather'),
      temperature_string: xpath_text(document, '/temperature_string')
    }
  end

  defp xpath_text(document, xpath) do
    :xmerl_xpath.string('/current_observation' ++ xpath, document)
    |> tap([element] ~> element)
    |> xmlElement(:content)
    |> tap([text] ~> text)
    |> xmlText(:value)
    |> String.Chars.to_string
  end
end