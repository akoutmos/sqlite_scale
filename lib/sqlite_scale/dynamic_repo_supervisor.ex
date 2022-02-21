defmodule SqliteScale.DynamicRepoSupervisor do
  @moduledoc """
  This supervision tree is used to start the registry
  and dynamic supervisor which handles each SQLite
  instance per user.
  """

  use Supervisor

  alias SqliteScale.DynamicRepoSupervisor.RepoHydrator
  alias SqliteScale.DynamicRepoSupervisor.RepoRegistry
  alias SqliteScale.DynamicRepoSupervisor.RepoSupervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @impl true
  def init(opts) do
    children = [
      RepoRegistry.child_spec(),
      RepoSupervisor,
      {RepoHydrator, opts}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
