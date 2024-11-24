defmodule CrmDemo.Customers do
  @moduledoc """
  The Crm context.
  """

  import Ecto.Query, warn: false
  alias CrmDemo.Repo

  alias CrmDemo.Customers.Customer
  alias CrmDemo.Customers.Profile

  @doc """
  Returns the list of customers.

  ## Examples

      iex> list_customers()
      [%Customer{}, ...]

  """
  def list_customers() do
    Customer
    |> Repo.all()
    |> Repo.preload(profiles: from(a in Profile, where: a.is_primary == true))
  end

  def list_customers_by_name(count \\ 5) do
    Customer
    |> from(limit: ^count)
    |> Repo.all()
  end

  @doc """
  Gets a single customer.

  Raises `Ecto.NoResultsError` if the Customer does not exist.

  ## Examples

      iex> get_customer!(123)
      %Customer{}

      iex> get_customer!(456)
      ** (Ecto.NoResultsError)

  """
  def get_customer!(id) do
    Repo.get!(Customer, id)
    |> Repo.preload(:profiles)
  end

  @doc """
  Creates a customer.

  ## Examples

      iex> create_customer(%{field: value})
      {:ok, %Customer{}}

      iex> create_customer(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_customer(attrs \\ %{}) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a customer.

  ## Examples

      iex> update_customer(customer, %{field: new_value})
      {:ok, %Customer{}}

      iex> update_customer(customer, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_customer(%Customer{} = customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a customer.

  ## Examples

      iex> delete_customer(customer)
      {:ok, %Customer{}}

      iex> delete_customer(customer)
      {:error, %Ecto.Changeset{}}

  """
  def delete_customer(%Customer{} = customer) do
    Repo.delete(customer)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking customer changes.

  ## Examples

      iex> change_customer(customer)
      %Ecto.Changeset{data: %Customer{}}

  """
  def change_customer(%Customer{} = customer, attrs \\ %{}) do
    Customer.changeset(customer, attrs)
  end

  @doc false
  def change_profile(%Profile{} = profile, attrs \\ %{}) do
    Profile.changeset(profile, attrs)
  end
end
