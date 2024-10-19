defmodule CrmDemo.Repo.Migrations.CreateCorporateProfiles do
  use Ecto.Migration

  def change do
    create table(:corporate_profiles) do
      add :profile_id, references("profiles", on_delete: :delete_all)

      add :corporate_name, :string, null: false
      add :corporate_name_kana, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
