defmodule CrmDemo.Repo.Migrations.CreateCorporateProfiles do
  use Ecto.Migration

  def change do
    create table(:corporate_profiles) do
      add :profile_id, references("profiles", on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end
  end
end
