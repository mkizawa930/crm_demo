defmodule CrmDemo.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :customer_number, :string, null: false
      add :type, :string, null: false
      add :is_active, :boolean, default: true, null: false
      add :deleted_at, :naive_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
