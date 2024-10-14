defmodule CrmDemo.Crm.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrmDemo.Crm

  schema "customers" do
    field :customer_number, :string
    field :type, Ecto.Enum, values: [:individual, :corporation]
    field :is_active, :boolean, default: false
    field :deleted_at, :naive_datetime

    has_one :profile, Crm.Profile

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:type, :is_active])
    |> validate_required([:is_active])
    |> cast_assoc(:profile) # 同時に保存する
  end
end
