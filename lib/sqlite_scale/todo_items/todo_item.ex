defmodule SqliteScale.TodoItems.TodoItem do
  @moduledoc """
  The todo item ecto schema
  """

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "todo_items" do
    field :item, :string

    timestamps()
  end

  @doc false
  def changeset(todo_item, attrs) do
    todo_item
    |> cast(attrs, [:item])
    |> validate_required([:item])
  end
end
