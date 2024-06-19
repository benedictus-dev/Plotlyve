defmodule PlotlyveWeb.DashboardLive.Edit do
  alias PlotlyveWeb.DashboardLive.NewPlotForm
  alias Plotlyve.CsvManagement
  alias Plotlyve.Plots.Plot
  alias Plotlyve.Plots
  import DashboardLive.Components
  import PlotlyveWeb.Layout
  alias Plotlyve.Accounts

  use PlotlyveWeb, :live_view

  def render(assigns) do
    assigns =
      assigns
      |> assign(
        base_url:
          case assigns.live_action do
            :new ->
              ~p"/"

            :edit ->
              ~p"/"
          end
      )

    ~H"""
    <.main_layout live_action={@live_action}>
      <section class="h-full">
        <header class="bg-stone-100 flex justify-between py-5 px-5">
          <%!-- Little to no time to implement updating the plot name when a validation occurs --%>
          <h2 class="text-xl subpixel-antialiased relative">
            <%!-- <span><.input name={@plot.name} value={@plot.name} /></span> --%>
            <span class="absolute translate-x-44 translate-y-2">
              <Heroicons.Outline.pencil class="h-5 w-5" />
            </span>
            <input type="text" value={@plot.name} class="rounded -py-1" />
          </h2>
          <aside class="flex gap-x-2 items-center">
            <%= if @user do %>
              <.link
                href={~p"/users/log_out"}
                method="delete"
                class=" flex items-center bg-blue-300 px-3 py-2 rounded text-[0.8125rem] leading-6 text-zinc-900 font-semibold hover:text-zinc-700"
              >
                <Heroicons.Outline.user class="h-5 w-5 mr-2" /> Log out
              </.link>
            <% end %>
          </aside>
        </header>
        <main class="flex  justify-between h-full ">
          <div class="flex-1">
            <div
              id="histo-gram"
              phx-hook="HistoGram"
              data-histogram-data={Jason.encode!(@histogram_data)}
            >
            </div>
          </div>
          <div class="w-4/12">
            <.data_form form={@form} />
          </div>
        </main>
      </section>
    </.main_layout>
    """
  end

  def mount(_, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {
      :ok,
      socket
      |> assign(plot_name: nil)
      |> assign(user: user)
      |> assign(page_title: "")
      |> assign(plot: %{})
      |> assign(histogram_data: nil)
      |> assign(form: to_form(%{"datasetname" => "iris", "expression" => "SepalWidth"}))
    }
  end

  def handle_params(params, _url, socket) do
    {
      :noreply,
      apply_action(socket, socket.assigns.live_action, params)
    }
  end

  def apply_action(socket, :new, params) do
    socket
    |> assign(:page_title, "New Plot")
    |> assign(
      :histogram_data,
      hd(CsvManagement.get_column_data_by_column_name_and_filename("iris.csv", "SepalWidth"))
      |> Map.get(:values)
      |> IO.inspect(label: "Dataclip")
    )
    |> assign(:plot, %Plot{name: params["name"]})
  end

  def handle_event("save-plot", params, socket) do
    IO.inspect(params, label: "TEsssss")
    # Irky  but quick fix
    changeset =
      socket.assigns.plot
      |> Plots.change_plot(%{
        expression: params["expression"],
        user_id: socket.assigns.user.id,
        csv_metadata_id:
          CsvManagement.get_csv_metadata_by_filename(params["datasetname"] <> ".csv")
          |> Map.get(:id)
      })
      |> Map.put(:action, :validate)

    if changeset.valid? do
      changes = Ecto.Changeset.apply_changes(changeset) |> Map.from_struct()

      case Plots.create_plot(changes) do
        {:ok, plot} ->
          #This is an antipattern
          CsvManagement.create_dataclip(%{
            plot_id: plot.id,
            dataclip: socket.assigns.histogram_data
          })

          {:noreply,
           socket
           |> put_flash(:info, "Plot created successfully")
           |> push_navigate(to: ~p"/plot/")}

        {:error, %Ecto.Changeset{} = changeset} ->
          IO.puts("Not created")
          {:noreply, socket}
      end
    else
      {:noreply, socket}
    end
  end

  defp validate_params(socket) do
  end
end
