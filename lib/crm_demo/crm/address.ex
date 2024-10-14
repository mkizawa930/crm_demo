defmodule CrmDemo.Crm.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :zipcode, :string
    field :prefecture, :string
    field :city, :string
    field :details, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:zip_code, :prefecture, :city, :details])
    |> validate_required([:zip_code, :prefecture, :city, :details])
  end
end
