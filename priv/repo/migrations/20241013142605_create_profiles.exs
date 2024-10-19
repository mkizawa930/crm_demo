defmodule CrmDemo.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles) do
      add :customer_id, references("customers", on_delete: :delete_all)
      add :profile_type, :string, null: false
      add :email, :string, null: false
      add :phone_number, :string, null: false
      add :label, :string, null: false
      add :is_primary, :bool, default: false, null: false
      add :index, :integer, default: 0, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
