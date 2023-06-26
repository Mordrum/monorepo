defmodule MordrumApiServer.Repo do
  use Ecto.Repo,
    otp_app: :mordrum_api_server,
    adapter: Ecto.Adapters.Postgres
end
