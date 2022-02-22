defmodule SqliteScale.TodoItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SqliteScale.TodoItems` context.
  """

  @doc """
  Generate a todo_item.
  """
  def todo_item_fixture(attrs \\ %{}) do
    {:ok, todo_item} =
      attrs
      |> Enum.into(%{
        item: "some item"
      })
      |> SqliteScale.TodoItems.create_todo_item()

    todo_item
  end
end
