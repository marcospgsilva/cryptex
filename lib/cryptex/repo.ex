defmodule Cryptex.Repo do
  use Ecto.Repo,
    otp_app: :cryptex,
    adapter: Ecto.Adapters.Postgres
end
