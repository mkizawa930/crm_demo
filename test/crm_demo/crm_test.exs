defmodule CrmDemo.CrmTest do
  use CrmDemo.DataCase

  alias CrmDemo.Crm

  describe "customers" do
    alias CrmDemo.Crm.Customer

    import CrmDemo.CrmFixtures

    @invalid_attrs %{is_active: nil, deleted_at: nil}

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Crm.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Crm.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      valid_attrs = %{is_active: true, deleted_at: ~N[2024-10-05 13:23:00]}

      assert {:ok, %Customer{} = customer} = Crm.create_customer(valid_attrs)
      assert customer.is_active == true
      assert customer.deleted_at == ~N[2024-10-05 13:23:00]
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Crm.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      update_attrs = %{is_active: false, deleted_at: ~N[2024-10-06 13:23:00]}

      assert {:ok, %Customer{} = customer} = Crm.update_customer(customer, update_attrs)
      assert customer.is_active == false
      assert customer.deleted_at == ~N[2024-10-06 13:23:00]
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Crm.update_customer(customer, @invalid_attrs)
      assert customer == Crm.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Crm.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Crm.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Crm.change_customer(customer)
    end
  end
end
