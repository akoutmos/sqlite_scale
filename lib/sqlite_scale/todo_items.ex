defmodule SqliteScale.TodoItems do
  @moduledoc """
  The TodoItems context.
  """

  import Ecto.Query, warn: false
  alias SqliteScale.UserRepo

  alias SqliteScale.TodoItems.TodoItem

  @doc """
  Returns the list of todo_items.

  ## Examples

      iex> list_todo_items()
      [%TodoItem{}, ...]

  """
  def list_todo_items(user) do
    UserRepo.with_dynamic_repo(user, fn ->
      UserRepo.all(TodoItem)
    end)
  end

  @doc """
  Gets a single todo_item.

  Raises `Ecto.NoResultsError` if the Todo item does not exist.

  ## Examples

      iex> get_todo_item!(123)
      %TodoItem{}

      iex> get_todo_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_todo_item!(user, id) do
    UserRepo.with_dynamic_repo(user, fn ->
      UserRepo.get!(TodoItem, id)
    end)
  end

  @doc """
  Creates a todo_item.

  ## Examples

      iex> create_todo_item(%{field: value})
      {:ok, %TodoItem{}}

      iex> create_todo_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_todo_item(user, attrs \\ %{}) do
    UserRepo.with_dynamic_repo(user, fn ->
      %TodoItem{}
      |> TodoItem.changeset(attrs)
      |> UserRepo.insert()
    end)
  end

  @doc """
  Updates a todo_item.

  ## Examples

      iex> update_todo_item(todo_item, %{field: new_value})
      {:ok, %TodoItem{}}

      iex> update_todo_item(todo_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_todo_item(user, %TodoItem{} = todo_item, attrs) do
    UserRepo.with_dynamic_repo(user, fn ->
      todo_item
      |> TodoItem.changeset(attrs)
      |> UserRepo.update()
    end)
  end

  @doc """
  Deletes a todo_item.

  ## Examples

      iex> delete_todo_item(todo_item)
      {:ok, %TodoItem{}}

      iex> delete_todo_item(todo_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_todo_item(user, %TodoItem{} = todo_item) do
    UserRepo.with_dynamic_repo(user, fn ->
      UserRepo.delete(todo_item)
    end)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking todo_item changes.

  ## Examples

      iex> change_todo_item(todo_item)
      %Ecto.Changeset{data: %TodoItem{}}

  """
  def change_todo_item(%TodoItem{} = todo_item, attrs \\ %{}) do
    TodoItem.changeset(todo_item, attrs)
  end
end
