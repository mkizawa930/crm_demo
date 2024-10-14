

defmodule CrmDemoWeb.FooLive do
  use CrmDemoWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      Foo Page
    </div>
    """
  end
end
