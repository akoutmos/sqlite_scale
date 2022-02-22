defmodule SqliteScale.TodoItems.TodoItem do
  @moduledoc """
  The todo item Ecto schema
  """

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :item, :string

    timestamps()
  end

  def create_changeset(%__MODULE__{} = todo_item, attrs) do
    todo_item
    |> cast(attrs, [:item])
    |> validate_required([:item])
  end
end
