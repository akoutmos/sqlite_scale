defmodule SqliteScale.TodoItemsTest do
  use SqliteScale.DataCase

  alias SqliteScale.TodoItems

  describe "todo_items" do
    alias SqliteScale.TodoItems.TodoItem

    import SqliteScale.TodoItemsFixtures

    @invalid_attrs %{item: nil}

    test "list_todo_items/0 returns all todo_items" do
      todo_item = todo_item_fixture()
      assert TodoItems.list_todo_items() == [todo_item]
    end

    test "get_todo_item!/1 returns the todo_item with given id" do
      todo_item = todo_item_fixture()
      assert TodoItems.get_todo_item!(todo_item.id) == todo_item
    end

    test "create_todo_item/1 with valid data creates a todo_item" do
      valid_attrs = %{item: "some item"}

      assert {:ok, %TodoItem{} = todo_item} = TodoItems.create_todo_item(valid_attrs)
      assert todo_item.item == "some item"
    end

    test "create_todo_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = TodoItems.create_todo_item(@invalid_attrs)
    end

    test "update_todo_item/2 with valid data updates the todo_item" do
      todo_item = todo_item_fixture()
      update_attrs = %{item: "some updated item"}

      assert {:ok, %TodoItem{} = todo_item} = TodoItems.update_todo_item(todo_item, update_attrs)
      assert todo_item.item == "some updated item"
    end

    test "update_todo_item/2 with invalid data returns error changeset" do
      todo_item = todo_item_fixture()
      assert {:error, %Ecto.Changeset{}} = TodoItems.update_todo_item(todo_item, @invalid_attrs)
      assert todo_item == TodoItems.get_todo_item!(todo_item.id)
    end

    test "delete_todo_item/1 deletes the todo_item" do
      todo_item = todo_item_fixture()
      assert {:ok, %TodoItem{}} = TodoItems.delete_todo_item(todo_item)
      assert_raise Ecto.NoResultsError, fn -> TodoItems.get_todo_item!(todo_item.id) end
    end

    test "change_todo_item/1 returns a todo_item changeset" do
      todo_item = todo_item_fixture()
      assert %Ecto.Changeset{} = TodoItems.change_todo_item(todo_item)
    end
  end
end
