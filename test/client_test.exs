defmodule WeatherGovClientTest do
  use ExUnit.Case

  alias WeatherGov.UriFormatter, as: UF
  alias WeatherGov.Client, as: Client

  test "fetch() returns a webservice payload" do
    :meck.new(UF)
    :meck.new(HTTPoison)
    :meck.expect(UF, :format, fn("foobar") -> "http://foobar" end)
    :meck.expect \
      HTTPoison,
      :get,
      fn("http://foobar") ->
        {:ok, %{status_code: 200, body: "fake_payload"}}
      end

    assert "fake_payload" == Client.fetch("foobar")

    assert :meck.validate(UF)
    assert :meck.validate(HTTPoison)

    :meck.unload(UF)
    :meck.unload(HTTPoison)
  end

  test "fetch() halts on HTTP error" do
    :meck.new(UF)
    :meck.new(HTTPoison)
    :meck.new(IO)
    :meck.new(System)
    :meck.expect(UF, :format, fn("foobar") -> "http://foobar" end)
    :meck.expect \
      HTTPoison,
      :get,
      fn("http://foobar") ->
        {:error, "Failed for some unknown reason"}
      end

    :meck.expect \
      IO,
      :puts,
      fn """
        HTTP request error.
        Details: Failed for some unknown reason.
        Exiting...
        """ -> end

    :meck.expect(System, :halt, fn (:abort) -> end)

    Client.fetch("foobar")

    assert :meck.validate(UF)
    assert :meck.validate(HTTPoison)
    assert :meck.validate(IO)
    assert :meck.validate(System)

    :meck.unload(UF)
    :meck.unload(HTTPoison)
    :meck.unload(IO)
    :meck.unload(System)
  end
end