defmodule CrmDemo.Repo.Migrations.CreateIndividualProfiles do
  use Ecto.Migration

  def change do
    create table(:individual_profiles) do
      add :profile_id, references("profiles", on_delete: :delete_all)
      add :first_name, :string, null: false
      add :last_name, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
