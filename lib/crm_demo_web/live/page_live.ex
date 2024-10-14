defmodule CrmDemoWeb.PageLive do
  use CrmDemoWeb, :live_view

  require Logger

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :current_page, "home")}
  end

  @impl true
  def handle_params(params, _url, socket) do
    Logger.info(params)
    {:noreply, assign(socket, params)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="flex">
      <%!-- <div class="w-[300px]">
        <%= live_render(@socket, CrmDemoWeb.SidebarLive, id: :sidebar) %>
      </div>
      <div class="flex-1 my-4">
        <%= case @current_page do %>
          <% "home" -> %>
            <h1>HomePage</h1>
          <% "foo" -> %>
            <h1>FooPage</h1>
          <% _ -> %>
            <h1>NotFound</h1>
        <% end %>
      </div> --%>

    </div>
    """
  end

  # defp handle_params(params, _url, socket) do
  #   {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  # end


end
