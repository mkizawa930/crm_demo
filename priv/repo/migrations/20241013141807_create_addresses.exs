defmodule CrmDemo.Repo.Migrations.CreateAddresses do
  use Ecto.Migration

  def change do
    create table(:addresses) do
      add :zipcode, :string
      add :prefecture, :string
      add :city, :string
      add :details, :text

      timestamps(type: :utc_datetime)
    end
  end
end
