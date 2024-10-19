defmodule CrmDemo.Customers.Address do
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
    |> cast(attrs, [:zipcode, :prefecture, :city, :details])
    |> validate_required([:zipcode, :prefecture, :city, :details])
  end
end
