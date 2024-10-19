defmodule CrmDemo.CustomersTest do
  use CrmDemo.DataCase

  alias CrmDemo.Customers

  describe "customers" do
    alias CrmDemo.Customers.Customer

    import CrmDemo.CustomersFixtures

    @invalid_attrs %{is_active: nil, deleted_at: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Customers.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a individual customer" do
      valid_attrs = %{
        profiles: [
          %{
            profile_type: :individual,
            email: "test@example.com",
            phone_number: "0123-1234-5678",
            index: 0
          }
        ]
      }

      assert {:ok, %Customer{profile: profile} = customer} =
               Customers.create_customer(valid_attrs)

      assert String.length(customer.customer_number) == 12
      assert customer.is_active == true
      assert customer.deleted_at == nil
      assert profile.profile_type == :individual
      assert profile.email == "test@example.com"
      assert profile.phone_number == "0123-1234-5678"
      assert profile.index == 0
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{is_active: false, deleted_at: ~N[2024-10-06 13:23:00]}

      assert {:ok, %Customer{} = customer} = Customers.update_customer(customer, update_attrs)
      assert customer.is_active == false
      assert customer.deleted_at == ~N[2024-10-06 13:23:00]
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_customer(customer, @invalid_attrs)
      assert customer == Customers.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Customers.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end
