defmodule KjlyMappAuth.Repo do
  otp = Application.get_env(:kjly_mapp_auth, :otp_app)
  IO.inspect otp, label: "gen_env otp_app"
  use Ecto.Repo,
    otp_app: otp,
    adapter: Ecto.Adapters.Postgres
end
