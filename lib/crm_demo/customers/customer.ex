defmodule CrmDemo.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias CrmDemo.Customers

  schema "customers" do
    field :customer_number, :string
    field :is_active, :boolean, default: true
    field :deleted_at, :naive_datetime, default: nil

    has_many :profiles, Customers.Profile

    timestamps(type: :utc_datetime)
  end

  def generate_customer_number() do
    length = 12 #
    chars = Enum.to_list(~c"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    Enum.map(1..length, fn _ -> Enum.random(chars) end) |> to_string
  end

  def put_customer_number(changeset) do
    customer_number = get_field(changeset, :customer_number)
    if customer_number == nil do
      put_change(changeset, :customer_number, generate_customer_number())
    end
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [])
    |> validate_required([])
    |> put_customer_number()
    |> cast_assoc(:profiles, with: &Customers.Profile.changeset/2)
  end
end
