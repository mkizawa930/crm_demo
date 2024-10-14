defmodule CrmDemoWeb.CustomerLive.New do
  use CrmDemoWeb, :live_view

  alias CrmDemo.Crm

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    customer_changeset = Crm.change_customer(%Crm.Customer{})
    {:ok, socket
    |> assign(:form, to_form(customer_changeset))
    |> assign(:from_path, "/customers")
    |> assign(:title, "顧客作成")}
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

end
