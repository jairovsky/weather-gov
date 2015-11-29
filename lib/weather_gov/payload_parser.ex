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
      credit: xpath_text(document, '/current_observation/credit'),
      credit_url: xpath_text(document, '/current_observation/credit_URL'),
      location: xpath_text(document, '/current_observation/location')
    }
  end

  defp xpath_text(document, xpath) do
    :xmerl_xpath.string(xpath, document)
    |> tap([element] ~> element)
    |> xmlElement(:content)
    |> tap([text] ~> text)
    |> xmlText(:value)
    |> String.Chars.to_string
  end
end