defmodule PlotlyveWeb.DashboardLive.Index do
  alias Ecto.Changeset
  use PlotlyveWeb, :live_view
  alias PlotlyveWeb.DashboardLive.NewPlotForm
  import DashboardLive.Components

  def mount(_, _session, socket) do
    {:ok,
     socket
     |> assign(plots: 1)
     |> assign_plot_name()
     |> clear_form()}
  end

  def handle_event(
        "create_plot",
        %{"new_plot_form" => plot_params},
        %{assigns: %{new_plot_name: new_plot_name}} = socket
      ) do
    changeset =
      new_plot_name
      |> NewPlotForm.change_plot(Map.put(plot_params, "user_id", Ecto.UUID.generate()))
      |> Map.put(:action, :validate)

    if changeset.valid? do
      {
        :noreply,
        socket
        |> push_navigate(to: ~p"/plot/new?#{%{name: Ecto.Changeset.get_field(changeset, :name)}}")
      }
    else
      {:noreply, socket |> assign_form(changeset)}
    end
  end

  def handle_event(
        "validate",
        %{"new_plot_form" => plot_params},
        %{assigns: %{new_plot_name: new_plot_name}} = socket
      ) do
    changeset =
      new_plot_name
      |> NewPlotForm.change_plot(Map.put(plot_params, "user_id", Ecto.UUID.generate()))
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def assign_plot_name(socket) do
    socket
    |> assign(:new_plot_name, %NewPlotForm{})
  end

  def clear_form(socket) do
    form =
      socket.assigns.new_plot_name
      |> NewPlotForm.change_plot()
      |> to_form()

    assign(socket, :form, form)
  end

  def assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
