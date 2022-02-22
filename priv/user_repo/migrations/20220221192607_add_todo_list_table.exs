defmodule SqliteScale.UserRepo.Migrations.AddTodoListTable do
  use Ecto.Migration

  def change do
    create table(:todo_items, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:item, :string, null: false)

      timestamps()
    end
  end
end
