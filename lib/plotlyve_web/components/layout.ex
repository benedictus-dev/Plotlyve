defmodule PlotlyveWeb.Layout do
  use Phoenix.Component
  import PlotlyveWeb.CoreComponents
  alias Phoenix.LiveView.JS
  use PlotlyveWeb, :html

  slot :inner_block, required: true
  attr :live_action, :atom ,required: false
  def main_layout(assigns) do
    ~H"""
    <section class=" grid grid-cols-9 h-full rouned">
      <nav class="flex flex-col bg-blue-600 col-span-1 rounded-l-lg flex flex-col justify-start gap-y-3 items-center overflow-hidden ">
        <div class="bg-blue-700 px-14 py-6 ">
          <.link class=" text-blue-100 font-bold border-2 border-sky-100 p-2" navigate={~p"/plot"}>
            Plotlyve
          </.link>
        </div>
        <hr />
        <div class="flex flex-col  gap-y-4">
          <.link
            class={"text-blue-50 text-sm font-medium inline-block flex gap-x-2 subpixel-antialiased " <> if @live_action == :index, do: "bg-blue-900 rounded p-2", else: ""}
            navigate={~p"/plot"}
          >
            <Heroicons.Outline.chart_square_bar class="h-5 w-5" /> My Plots
          </.link>
          <.link class=" text-blue-50 text-sm font-medium inline-block flex gap-x-2  subpixel-antialiased">
            <Heroicons.Outline.users class="h-5 w-5" /> Shared with me
          </.link>
        </div>
      </nav>
      <main class="col-span-8">
        <%= render_slot(@inner_block) %>
      </main>
    </section>
    """
  end
end
