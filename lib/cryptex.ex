defmodule Cryptex do
  @moduledoc """
  Cryptex keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @default_currencies ["BTC", "ETH", "LTC", "ADA"]

  defdelegate get_currency_info(currency, key), to: Cryptex.CurrencyAgent

  def start_streaming(quote_symbol, currencies \\ @default_currencies) do
    add_to_dynamic_supervisor(Cryptex.CurrencyAgent, currencies)

    currencies
    |> Enum.each(fn currency ->
      add_to_dynamic_supervisor(Cryptex.CurrencySocket, %{
        currency: currency,
        quote_symbol: quote_symbol
      })
    end)
  end

  defp add_to_dynamic_supervisor(module, state) do
    DynamicSupervisor.start_child(
      CurrenciesSupervisor,
      {module, state}
    )
  end
end
