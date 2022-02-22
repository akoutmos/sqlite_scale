defmodule SqliteScale.UserRepo.Migrations.AddTodoListTable do
  use Ecto.Migration

  def change do
    create table(:todo_items) do
      add(:item, :string, null: false)

      timestamps()
    end
  end
end
