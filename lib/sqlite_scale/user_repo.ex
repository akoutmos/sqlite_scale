defmodule SqliteScale.UserRepo do
  use Ecto.Repo,
    otp_app: :sqlite_scale,
    adapter: Ecto.Adapters.SQLite3

  alias SqliteScale.Accounts.User
  alias SqliteScale.DynamicRepoSupervisor.RepoRegistry

  def with_dynamic_repo(%User{} = user, callback) do
    with {:ok, repo} <- RepoRegistry.lookup_repo(user) do
      __MODULE__.put_dynamic_repo(repo)
      callback.()
    end
  end
end
