defmodule CrmDemo.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :zip_code, :string
      add :state, :string
      add :city, :string
      add :street, :text

      timestamps(type: :utc_datetime)
    end
  end
end
