defmodule SqliteScale.DynamicRepoSupervisor.RepoHydrator do
  @moduledoc """
  This GenServer will start all of the repo processes dynamically
  based on what is in the priv dir.
  """

  use GenServer

  alias SqliteScale.Accounts
  alias SqliteScale.Accounts.User
  alias SqliteScale.DynamicRepoSupervisor.RepoSupervisor

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(opts) do
    Accounts.list_users()
    |> Enum.each(fn %User{} = user ->
      RepoSupervisor.add_repo_to_supervisor(user)
    end)

    :ignore
  end
end
