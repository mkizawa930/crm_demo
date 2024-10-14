defmodule CrmDemo.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :customer_id, references("customers", on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end
