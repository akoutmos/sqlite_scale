defmodule SqliteScale.Repo do
  use Ecto.Repo,
    otp_app: :sqlite_scale,
    adapter: Ecto.Adapters.SQLite3
end
