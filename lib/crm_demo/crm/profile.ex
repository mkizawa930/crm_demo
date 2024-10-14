defmodule CrmDemo.Crm.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrmDemo.Crm

  schema "profiles" do
    field :type, Ecto.Enum, values: [:individual, :corporation]
    field :email, :string
    field :phone_number_primary, :string
    field :phone_number_secondary, :string

    belongs_to :customer, Crm.Customer

    has_one :individual_profile, Crm.IndividualProfile
    has_one :corporate_profile, Crm.CorporateProfile

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:customer_id, :type, :address_id])
    |> validate_required([])
  end
end
