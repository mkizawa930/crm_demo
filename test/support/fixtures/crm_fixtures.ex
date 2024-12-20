defmodule CrmDemo.CustomersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CrmDemo.Customers` context.
  """

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        deleted_at: ~N[2024-10-05 13:23:00],
        is_active: true
      })
      |> CrmDemo.Customers.create_customer()

    customer
  end
end
