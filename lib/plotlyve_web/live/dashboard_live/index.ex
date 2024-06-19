defmodule PlotlyveWeb.DashboardLive.Index do
  alias Plotlyve.CsvManagement
  use PlotlyveWeb, :live_view
  alias PlotlyveWeb.DashboardLive.{NewPlotForm, SelectUser}
  import PlotlyveWeb.Layout
  import DashboardLive.Components
  alias Plotlyve.{Accounts, Plots, Collaboration}

  def mount(_, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])
    IO.inspect(user, label: "user")

    {:ok,
     socket
     |> assign(plots: Plots.list_plots())
     |> assign(user: user)
     |> assign(plot_id: "")
     |> assign_collaborators()
     |> assign_plot_name()
     |> clear_share()
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

  def handle_event("share-plot", params, socket) do
    changeset =
      PlotlyveWeb.DashboardLive.SelectUser.change_user(%{email: params["share-plot"]})
      |> Map.put(:action, :validate)
      |> IO.inspect(label: "Outcome")

    if changeset.valid? do
      # Oban should be used to schedule this JOB
      dataclip_id =
        CsvManagement.get_dataclip_id_for_plot(socket.assigns.plot_id)

      Collaboration.create_share(%{user_id: params["share-plot"], dataclip_id: dataclip_id})

      {
        :noreply,
        socket
        |> put_flash(:info, "plot shared")
        |> redirect(to: ~p"/plot")
      }
    else
      {:noreply, socket |> assign_select(changeset)}
    end
  end

  def handle_event("plot_id", params, socket) do
    IO.inspect(params["plot"], label: "Params")

    {:noreply,
     socket
     |> assign(plot_id: params["plot"])}
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

  def clear_share(socket) do
    share =
      SelectUser.change_user()
      |> to_form()

    assign(socket, :share, share)
  end

  def assign_form(socket, changeset) do
    assign(socket, :form, to_form(changeset))
  end

  def assign_select(socket, changeset) do
    assign(socket, :share, to_form(changeset))
  end

  def assign_collaborators(socket) do
    collaborators =
      Accounts.get_registered_users(socket.assigns.user.email)
      |> Enum.map(fn {key, value} -> {String.to_atom(key), value} end)
      |> IO.inspect(label: "Collaboar")

    assign(socket, :share_with, collaborators)
  end
end
