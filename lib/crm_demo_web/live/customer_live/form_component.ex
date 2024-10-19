defmodule CrmDemoWeb.CustomerLive.FormComponent do
  use CrmDemoWeb, :live_component

  alias CrmDemo.Customers
  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <%!-- <:subtitle>Use this form to manage customer records in your database.</:subtitle> --%>
      </.header>

      <.simple_form
        for={@form}
        id="customer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <div class="flex flex-row space-x-4">
          <div class="flex-1">
            <.input field={@form[:first_name]} type="text" label="姓" />
          </div>
          <div class="flex-1">
            <.input field={@form[:last_name]} type="text" label="名" />
          </div>
        </div>
        <div class="flex flex-row space-x-4">
          <div class="flex-1">
            <.input field={@form[:first_name_kana]} type="text" label="姓(カナ)" />
          </div>
          <div class="flex-1">
            <.input field={@form[:last_name_kana]} type="text" label="名(カナ)" />
          </div>
        </div>
        <.input
          field={@form[:gender]}
          type="select"
          label="性別"
          prompt="性別を選択してください"
          options={[{"男", "male"}, {"女", "female"}]}
        />
        <.input field={@form[:birth_date]} type="date" label="生年月日" />
        <%!-- <.input field={@form[:is_active]} type="checkbox" label="Is active" /> --%>
        <%!-- <.input field={@form[:deleted_at]} type="datetime-local" label="Deleted at" /> --%>
        <:actions>
          <div class="flex w-full justify-end space-x-4">
            <.button class="bg-zinc-400" type="button" phx-target={@myself} phx-click="cancel">
              キャンセル
            </.button>
            <.button phx-disable-with="Saving...">登録</.button>
          </div>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{customer: customer} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Customers.change_customer(customer))
     end)}
  end

  @impl true
  def handle_event("validate", %{"customer" => customer_params}, socket) do
    changeset = Customers.change_customer(socket.assigns.customer, customer_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{}, socket) do
    save_customer(socket, socket.assigns.action, %{:is_active => true})
  end

  def handle_event("save", %{"customer" => customer_params}, socket) do
    save_customer(socket, socket.assigns.action, customer_params)
  end

  def handle_event("cancel", _params, socket) do
    Logger.info("cancel")
    {:noreply, socket |> push_patch(to: socket.assigns.patch)}
  end

  defp save_customer(socket, :edit, customer_params) do
    case Customers.update_customer(socket.assigns.customer, customer_params) do
      {:ok, customer} ->
        notify_parent({:saved, customer})

        {:noreply,
         socket
         |> put_flash(:info, "Customer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_customer(socket, :new, customer_params) do
    case Customers.create_customer(customer_params) do
      {:ok, customer} ->
        notify_parent({:saved, customer})

        {:noreply,
         socket
         |> put_flash(:info, "Customer created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
