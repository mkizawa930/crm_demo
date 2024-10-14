defmodule CrmDemo.Crm.CorporateProfile do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrmDemo.Crm

  schema "corporate_profiles" do
    belongs_to :profile, Crm.Profile

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(corporate_profile, attrs) do
    corporate_profile
    |> cast(attrs, [])
    |> validate_required([])
  end
end
