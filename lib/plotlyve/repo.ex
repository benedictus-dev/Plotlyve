defmodule Plotlyve.Repo do
  use Ecto.Repo,
    otp_app: :plotlyve,
    adapter: Ecto.Adapters.Postgres
end
