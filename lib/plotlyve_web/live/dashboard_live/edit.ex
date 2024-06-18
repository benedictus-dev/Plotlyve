defmodule PlotlyveWeb.DashboardLive.Edit do
  alias PlotlyveWeb.DashboardLive.NewPlotForm
  alias Plotlyve.CsvManagement
  alias Plotlyve.Plots.Plot
  import DashboardLive.Components
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
          <Heroicons.Outline.user class="h-5 w-5" /> BY
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
    """
  end

  def mount(_, _, socket) do
    {
      :ok,
      socket
      |> assign(plot_name: nil)
      |> assign(page_title: "")
      |> assign(plot: %{})
      |> assign(histogram_data: nil)
      |> assign(form: to_form(%{"datasetname" => "iris", "expression" => "SepalWidth"}))
    }
  end

  def handle_params(params, url, socket) do
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
    )
    |> assign(:plot, %NewPlotForm{name: params["name"]})
  end

  def handle_event("save-plot", params, socket) do
    IO.inspect(params,label: "TEsssss")
    {:noreply, socket}
  end
end
