defmodule CrmDemo.Customers.CorporateProfile do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrmDemo.Customers

  schema "corporate_profiles" do
    field :corporate_name, :string
    field :corporate_name_kana, :string

    belongs_to :profile, Customers.Profile

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(corporate_profile, attrs) do
    corporate_profile
    |> cast(attrs, [:corporate_name, :corporate_name_kana])
    |> validate_required([])
  end
end
