import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :kjly_mapp_auth, KjlyMappAuth.Repo,
  username: System.get_env("PSQL_USERNAME"),
  password: System.get_env("PSQL_PASSWORD"),
  hostname: System.get_env("PSQL_HOSTNAME"),
  database: "kjly_mapp_auth_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kjly_mapp_auth, KjlyMappAuthWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "76OAuUoLcKyVbfX1LZpK3TcrdElODl9jNavc9NO7D46d5opgyXiAuj8oSafUrIEY",
  server: false

# In test we don't send emails.
config :kjly_mapp_auth, KjlyMappAuth.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
