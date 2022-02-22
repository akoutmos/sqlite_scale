defmodule SqliteScaleWeb.TodoItemControllerTest do
  use SqliteScaleWeb.ConnCase

  import SqliteScale.TodoItemsFixtures

  @create_attrs %{item: "some item"}
  @update_attrs %{item: "some updated item"}
  @invalid_attrs %{item: nil}

  describe "index" do
    test "lists all todo_items", %{conn: conn} do
      conn = get(conn, Routes.todo_item_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Todo items"
    end
  end

  describe "new todo_item" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.todo_item_path(conn, :new))
      assert html_response(conn, 200) =~ "New Todo item"
    end
  end

  describe "create todo_item" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.todo_item_path(conn, :create), todo_item: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.todo_item_path(conn, :show, id)

      conn = get(conn, Routes.todo_item_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Todo item"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.todo_item_path(conn, :create), todo_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Todo item"
    end
  end

  describe "edit todo_item" do
    setup [:create_todo_item]

    test "renders form for editing chosen todo_item", %{conn: conn, todo_item: todo_item} do
      conn = get(conn, Routes.todo_item_path(conn, :edit, todo_item))
      assert html_response(conn, 200) =~ "Edit Todo item"
    end
  end

  describe "update todo_item" do
    setup [:create_todo_item]

    test "redirects when data is valid", %{conn: conn, todo_item: todo_item} do
      conn = put(conn, Routes.todo_item_path(conn, :update, todo_item), todo_item: @update_attrs)
      assert redirected_to(conn) == Routes.todo_item_path(conn, :show, todo_item)

      conn = get(conn, Routes.todo_item_path(conn, :show, todo_item))
      assert html_response(conn, 200) =~ "some updated item"
    end

    test "renders errors when data is invalid", %{conn: conn, todo_item: todo_item} do
      conn = put(conn, Routes.todo_item_path(conn, :update, todo_item), todo_item: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Todo item"
    end
  end

  describe "delete todo_item" do
    setup [:create_todo_item]

    test "deletes chosen todo_item", %{conn: conn, todo_item: todo_item} do
      conn = delete(conn, Routes.todo_item_path(conn, :delete, todo_item))
      assert redirected_to(conn) == Routes.todo_item_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.todo_item_path(conn, :show, todo_item))
      end
    end
  end

  defp create_todo_item(_) do
    todo_item = todo_item_fixture()
    %{todo_item: todo_item}
  end
end
