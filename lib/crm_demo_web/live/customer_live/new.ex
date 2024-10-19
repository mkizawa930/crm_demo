defmodule CrmDemoWeb.CustomerLive.New do
  use CrmDemoWeb, :live_view

  alias CrmDemo.Customers
  alias CrmDemo.Customers.Customer
  alias CrmDemo.Customers.Profile
  alias CrmDemo.Customers.IndividualProfile
  alias CrmDemo.Customers.CorporateProfile

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    customer = %Customer{
      profiles: [
        %Profile{
          profile_type: :corporation,
          label: "顧客住所",
          is_primary: true,
          individual: %IndividualProfile{},
          corporation: %CorporateProfile{}
        }
      ]
    }

    {:ok,
     socket
     |> assign(:customer, customer)
     |> assign(:profile_type, "corporation")
     |> assign(:changeset, Customers.change_customer(customer))
     |> assign(:from_path, "/customers")
     |> assign(:title, "新規顧客登録")}
  end

  # @impl true
  # @spec handle_params(any(), any(), any()) :: {:noreply, any()}
  # def handle_params(_params, url, socket) do
  #   Logger.info("#{url}")
  #   prev_url = String.split(url, "/")
  #     |> List.delete_at(-1)
  #     |> Enum.join("/")
  #   {:noreply, assign(socket, :from_path, prev_url)}
  # end

  @impl true
  @spec handle_event(<<_::48>>, any(), Phoenix.LiveView.Socket.t()) ::
          {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_event("cancel", _params, socket) do
    {:noreply, socket |> push_navigate(to: "/customers")}
  end

  @impl true
  def handle_event("validate", %{"customer" => customer_params}, socket) do
    customer_params = form_to_params(customer_params)

    profile_type =
      Map.get(customer_params, "profiles")
      |> Enum.at(0)
      |> Map.get("profile_type", socket.assigns.profile_type)

    Logger.info(profile_type)
    changeset = Customers.change_customer(socket.assigns.customer, customer_params)
    {:noreply, socket |> assign(:profile_type, profile_type) |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("save", %{"customer" => customer_params}, socket) do
    customer_params = form_to_params(customer_params)

    # {:ok, customer} = Customers.create_customer(customer_params)
    {:noreply, socket}
  end

  defp form_to_params(customer_params) do
    profiles =
      Map.get(customer_params, "profiles", %{}) |> Enum.map(fn {_, profile} -> profile end)

    Map.put(customer_params, "profiles", profiles)
  end
end
