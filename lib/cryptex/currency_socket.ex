defmodule Cryptex.CurrencySocket do
  @moduledoc """
   WebSocket for currencies data

  """
  use WebSockex
  alias Cryptex.CurrencyAgent

  def start_link(%{currency: currency, quote_symbol: quote_symbol}) do
    downcase_currency = String.downcase(currency)
    quote_symbol = String.downcase(quote_symbol)

    WebSockex.start_link(
      get_binance_api_base_url("/#{downcase_currency}#{quote_symbol}@ticker"),
      __MODULE__,
      %{currency: currency}
    )
  end

  @impl true
  def handle_frame({_type, msg}, %{currency: currency} = state) do
    with {:ok, currency_data} <- Jason.decode(msg) do
      CurrencyAgent.update_currencies_data({currency, currency_data})
    end

    {:ok, state}
  end

  def get_binance_api_base_url(path),
    do: Application.get_env(:cryptex, Cryptex.Requests)[:binance_data_api_base_url] <> path
end
