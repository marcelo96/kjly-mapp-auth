defmodule KjlyMappAuth.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    schema = "auth"
    table = "users"
    path = "#{schema}.#{table}"

    execute "CREATE EXTENSION IF NOT EXISTS citext", ""
    execute """
      CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    """, ""
    execute """
      CREATE EXTENSION IF NOT EXISTS pgcrypto;
    """, ""

    execute "CREATE SCHEMA IF NOT EXISTS #{schema}", "DROP SCHEMA IF EXISTS #{schema}"

    create table(:users, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :email, :citext, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :naive_datetime
      timestamps()
    end

    execute("ALTER TABLE #{path} ALTER COLUMN id SET DEFAULT uuid_generate_v4();","")
    create unique_index(:users, [:email], prefix: schema)

    create table(:users_tokens, primary_key: false, prefix: schema) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id, on_delete: :delete_all), null: false
      add :token, :binary, null: false
      add :context, :string, null: false
      add :sent_to, :string
      timestamps(updated_at: false)
    end

    create index(:users_tokens, [:user_id], prefix: schema)
    create unique_index(:users_tokens, [:context, :token], prefix: schema)
  end
end
