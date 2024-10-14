defmodule CrmDemoWeb.CustomerLive.Index do
  use CrmDemoWeb, :live_view

  alias CrmDemo.Crm
  alias CrmDemo.Crm.Customer

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    customers = Crm.list_customers()
    Logger.info("customers: #{customers}")
    {:ok, stream(socket, :customers, customers)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    Logger.info(params)
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "顧客情報編集")
    |> assign(:customer, Crm.get_customer!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "新規顧客登録")
    |> assign(:customer, %Customer{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "顧客一覧")
    |> assign(:customer, nil)
  end

  @impl true
  def handle_info({CrmDemoWeb.CustomerLive.FormComponent, {:saved, customer}}, socket) do
    {:noreply, stream_insert(socket, :customers, customer)}
  end

  @impl true
  @spec handle_event(<<_::48>>, map(), any()) :: {:noreply, any()}
  def handle_event("search", %{"keyword" => keyword}, socket) do
    Logger.info("search customers by #{keyword}")
    {:noreply, socket}
  end


  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    customer = Crm.get_customer!(id)
    {:ok, _} = Crm.delete_customer(customer)

    {:noreply, stream_delete(socket, :customers, customer)}
  end
end
