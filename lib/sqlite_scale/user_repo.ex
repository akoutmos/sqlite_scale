defmodule SqliteScale.UserRepo do
  use Ecto.Repo,
    otp_app: :sqlite_scale,
    adapter: Ecto.Adapters.SQLite3,
    database: nil

  require Logger

  alias SqliteScale.Accounts.User
  alias SqliteScale.DynamicRepoSupervisor.RepoRegistry

  def with_dynamic_repo(%User{} = user, callback) do
    with {:ok, repo} <- RepoRegistry.lookup_repo(user) do
      try do
        __MODULE__.put_dynamic_repo(repo)
        callback.()
      after
        __MODULE__.put_dynamic_repo(nil)
      end
    else
      error ->
        Logger.warning("Failed to get UserRepo for user: #{inspect(user)}")
    end
  end
end
