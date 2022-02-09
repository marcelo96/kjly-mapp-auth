defmodule KjlyMappAuth.Repo do
  use Ecto.Repo,
    otp_app: :kjly_mapp_auth,
    adapter: Ecto.Adapters.Postgres
end
