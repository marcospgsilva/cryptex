defmodule Cryptex.DynamicSupervisor do
  @moduledoc """
   Currencies Supervisor
  """
  use DynamicSupervisor

  def start_link(attrs),
    do: DynamicSupervisor.start_link(__MODULE__, attrs, name: CurrenciesSupervisor)

  @impl true
  def init(_init_arg),
    do: DynamicSupervisor.init(strategy: :one_for_one)
end
