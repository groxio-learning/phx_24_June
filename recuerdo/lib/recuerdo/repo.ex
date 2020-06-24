defmodule Recuerdo.Repo do
  use Ecto.Repo,
    otp_app: :recuerdo,
    adapter: Ecto.Adapters.Postgres
end
