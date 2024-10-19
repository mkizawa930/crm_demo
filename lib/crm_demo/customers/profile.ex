defmodule CrmDemo.Customers.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrmDemo.Customers

  schema "profiles" do
    field :profile_type, Ecto.Enum, values: [:individual, :corporation]
    field :label, :string
    field :email, :string
    field :phone_number, :string
    field :is_primary, :boolean, default: false
    field :index, :integer, default: 0

    belongs_to :customer, Customers.Customer
    # belongs_to :address, Customers.Address
    has_one :individual, Customers.IndividualProfile
    has_one :corporation, Customers.CorporateProfile

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(profile, attrs \\ %{}) do
    profile
    |> cast(attrs, [:profile_type, :label, :email, :phone_number, :is_primary, :index])
    |> validate_required([:profile_type, :label, :email, :phone_number, :is_primary, :index])
    # |> cast_assoc(:address, with: &Customers.Address.changeset/2)
    |> cast_assoc(:individual, with: &Customers.IndividualProfile.changeset/2)
    |> cast_assoc(:corporation, with: &Customers.CorporateProfile.changeset/2)
  end
end
