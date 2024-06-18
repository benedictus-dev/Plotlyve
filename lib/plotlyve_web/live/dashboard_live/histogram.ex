defmodule PlotlyveWeb.DashboardLive.Histogram do
  use Phoenix.LiveComponent

  def update(assigns, socket) do
    {
      :ok,
      socket
      |> assign(assigns)
    }
  end

  def render(assigns) do
    ~H"""
    <div>
      
    </div>
    """
  end
end
