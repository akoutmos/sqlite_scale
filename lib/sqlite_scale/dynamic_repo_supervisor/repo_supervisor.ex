defmodule SqliteScale.DynamicRepoSupervisor.RepoSupervisor do
  @moduledoc """
  This module is responsible for starting the repos as
  they are needed.
  """

  use DynamicSupervisor

  require Logger

  alias SqliteScale.Accounts.User
  alias SqliteScale.DynamicRepoSupervisor.RepoRegistry
  alias SqliteScale.UserRepo

  @doc """
  This function is used to start the DynamicSupervisor in the supervision tree
  """
  def start_link(opts) do
    DynamicSupervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(_opts) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @doc """
  Start a new repo process and adds it to the DynamicSupervisor.
  """
  def add_repo_to_supervisor(%User{} = user) do
    user_id = Ecto.UUID.cast!(user.id)

    database_file =
      :sqlite_scale
      |> :code.priv_dir()
      |> Path.join("/user_repo/db_files/#{user_id}/")
      |> Path.join("user_data.db")

    repo_opts = [
      name: {:via, Registry, {RepoRegistry, user_id}},
      database: database_file,
      pool_size: 5,
      show_sensitive_data_on_connection_error: true
    ]

    child_spec = %{
      id: UserRepo,
      start: {UserRepo, :start_link, [repo_opts]},
      restart: :permanent
    }

    {:ok, pid} = DynamicSupervisor.start_child(__MODULE__, child_spec)
    run_migrations(user, pid)

    pid
  end

  @doc """
  Gets all of the PIDs upnder this DynamicSupervisor.
  """
  def all_repo_pids do
    __MODULE__
    |> DynamicSupervisor.which_children()
    |> Enum.reduce([], fn {_, repo_pid, _, _}, acc ->
      [repo_pid | acc]
    end)
  end

  defp run_migrations(user, repo_pid) do
    # Run any pending migrations
    user
    |> UserRepo.with_dynamic_repo(fn ->
      Ecto.Migrator.run(UserRepo, :up, all: true, dynamic_repo: repo_pid)
    end)
    |> case do
      [] ->
        Logger.info("The database did not have any pending migrations")

      migrations when is_list(migrations) ->
        Logger.info("The database for UserRepo has applied the following migrations: #{Enum.join(migrations, ", ")}")
    end
  end
end
