defmodule SqliteScale.DynamicRepoSupervisor.RepoRegistry do
  @moduledoc """
  This module is responsible for keeping track of all of the
  SQLite repos that are currently running.
  """

  alias SqliteScale.Accounts.User

  @doc """
  This function returns the child spec for this module so that it
  can easily be added to the supervision tree.
  """
  def child_spec do
    Registry.child_spec(
      keys: :unique,
      name: __MODULE__,
      partitions: System.schedulers_online()
    )
  end

  @doc """
  This function looks up a repo process by its ID so that the
  processes can be then interacted with via its PID.
  """
  def lookup_repo(%User{id: user_id}) do
    case Registry.lookup(__MODULE__, Ecto.UUID.cast!(user_id)) do
      [{repo_pid, _}] ->
        {:ok, repo_pid}

      [] ->
        {:error, :not_found}
    end
  end

  # The below functions are used under the hood when leveraging :via
  # to process PID lookup through a registry.

  @doc false
  def whereis_name(user_id) do
    case lookup_repo(user_id) do
      {:ok, repo_id} -> repo_id
      _ -> :undefined
    end
  end
end
