defmodule Cryptex.CurrencyAgent do
  @moduledoc """
    Currencies state
  """
  use Agent

  def start_link(currencies),
    do:
      Agent.start_link(
        fn ->
          currencies
          |> Enum.reduce(%{}, fn currency, acc ->
            acc |> Map.put(currency, %{})
          end)
        end,
        name: CurrencyAgent
      )

  def get_currency_info(symbol, key) do
    with {:ok, currency_data} <- String.upcase(symbol) |> find_currency_data() do
      get_data_by_key(currency_data, key)
    end
  end

  def find_currency_data(nil), do: {:error, :invalid_symbol}

  def find_currency_data({_symbol, currency_data}), do: {:ok, currency_data}

  def find_currency_data(currency) do
    get_data()
    |> Enum.find(fn {symbol, _data} -> symbol == currency end)
    |> find_currency_data()
  end

  def get_data_by_key(currency_data, :last_price), do: {:ok, currency_data["c"]}
  def get_data_by_key(currency_data, :open_price), do: {:ok, currency_data["o"]}
  def get_data_by_key(currency_data, :high_price), do: {:ok, currency_data["h"]}
  def get_data_by_key(currency_data, :low_price), do: {:ok, currency_data["l"]}
  def get_data_by_key(_, _), do: {:error, :invalid_key}

  def get_data, do: Agent.get(CurrencyAgent, & &1)

  def update_currencies_data({currency, data}) do
    Agent.get_and_update(CurrencyAgent, fn currencies ->
      {currencies, Map.put(currencies, currency, data)}
    end)
  end
end
