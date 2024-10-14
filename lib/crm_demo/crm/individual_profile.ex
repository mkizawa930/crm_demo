defmodule CrmDemo.Crm.IndividualProfile do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrmDemo.Crm

  schema "individual_profiles" do
    field :first_name, :string
    field :last_name, :string
    field :first_name_kana, :string
    field :last_name_kana, :string
    field :gender, Ecto.Enum, values: [:male, :female]
    field :birth_date, :date

    belongs_to :profile, Crm.Profile
    belongs_to :address, Crm.Address

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(individual_profile, attrs) do
    individual_profile
    |> cast(attrs, [])
    |> validate_required([])
  end
end
