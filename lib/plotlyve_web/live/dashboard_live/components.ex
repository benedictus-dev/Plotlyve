defmodule DashboardLive.Components do
  use Phoenix.Component
  import PlotlyveWeb.CoreComponents
  alias Phoenix.LiveView.JS
  use PlotlyveWeb, :html

  def simple_table(assigns) do
    ~H"""
    <table>
      <tr>
        <%= for col <- @column do %>
          <th><%= col.label %></th>
        <% end %>
      </tr>
      <%= for row <- @rows do %>
        <tr>
          <%= for col <- @column do %>
            <td>
              <%= render_slot(col, row) %> <button phx-click={JS.navigate("/plot/new")}>Edit</button>
            </td>
          <% end %>
        </tr>
      <% end %>
    </table>
    """
  end

  def create_plot(assigns) do
    ~H"""
    <button
      class="bg-blue-600 rounded text-blue-100 px-3 py-2 font-bold text-sm"
      phx-click={show_modal("plot_modal")}
    >
      Create new plot
    </button>
    """
  end

  def create_plot_modal(assigns) do
    ~H"""
    <.modal id="plot_modal" heading_text="Let's get started !!">
      <main>
        <.simple_form for={@form} id="new_plot_name" phx-submit="create_plot" phx-change="validate">
          <.input field={@form[:name]} label="Name" phx-debounce="blur" />
          <button
            class="bg-blue-500 font-bold px-6 py-2 rounded text-white mr-3"
            phx-disable-with="Creating plot"
          >
            Create Plot
          </button>
          <button
            type="button"
            class="text-black-500 font-bold border-2 border-black px-4 py-1 text-gray-600 rounded"
            phx-click={hide_modal("plot_modal")}
          >
            Cancel
          </button>
        </.simple_form>
      </main>
      <footer class=" mt-4 flex justify-end"></footer>
    </.modal>
    """
  end

  def my_plots(assigns) do
    assigns =
      assigns
      |> assign(email: "user@gmail.com")

    ~H"""
    <section class=" px-5 mt-7">
      <header class=" flex justify-between ">
        <h2>Total Plots <%= length(@plots) %></h2>
        <.create_plot />
      </header>
      <%!--
      <.simple_table rows={@plots}>
        <:column :let={plot} label="Name">
          <%= plot.name %>
        </:column>
        <:column :let={plot} label="Age">
          <%= plot.expression %>
        </:column>
      </.simple_table> --%>

      <div class="w-5/6 mx-auto">
        <.table id="plots" rows={@plots} row_click={}>
          <:col :let={plot} label="Name"><%= plot.name %></:col>
          <:col :let={plot} label="Expression"><%= plot.expression %></:col>
          <:col :let={_plot} label="Shared with"><%= @email %></:col>
          <:action>
            <.link
              class="bg-blue-300 rounded px-2 inline-block text-blue-900"
              navigate={~p"/plot/:id/edit"}
            >
              Edit
            </.link>
          </:action>
          <:action>
            <button
              class="bg-blue-300 rounded px-2 text-blue-900"
              phx-click={show_modal("share-modal")}
            >
              Share
            </button>
          </:action>
        </.table>
      </div>
    </section>
    """
  end

  # attr :datasetname, :string, default: "Iris"
  # attr :expression, :string, default: "SepalWidth"

  def data_form(assigns) do
    ~H"""
    <.form
      for={@form}
      class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4"
      phx-validate="validate"
      phx-submit="save-plot"
    >
      <div class="mb-4">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="datasetname">
          Dataset name
        </label>
        <.input
          field={@form[:datasetname]}
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          placeholder="iris"
        />
      </div>
      <div class="mb-6">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="expression">
          Expression
        </label>
        <.input
          field={@form[:expression]}
          class="shadow appearance-none border  rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          placeholder="SepalWidth"
        />
      </div>

      <button
        class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
        type="submit"
      >
        Save
      </button>
    </.form>
    """
  end

  attr :form, :map, required: true

  def plot_form(assigns) do
    ~H"""
    <.simple_form for={@form} phx-change="validate">
      <.input field={@form[:email]} />
    </.simple_form>
    """
  end

  def share_modal(assigns) do
    ~H"""
    <.modal id="share-modal" heading_text="Share your plot ">
      <main>
        <.simple_form for={@share} class="mt-10 space-y-8 bg-white" id="share-plot" phx-submit="share-plot">
          <.input
            options={@share_with}
            type="select"
            name="share-plot"
            field={@share[:email]}
            label="Select user"
            prompt=""
          />
          <div class="flex justify-between">
            <button
              class="bg-blue-500 font-bold px-6 py-2 rounded text-white mr-3"
              phx-disable-with="Sharing plot"
            >
              Share
            </button>
            <button
              type="button"
              class="text-black-500 font-bold border-2 border-black px-4 py-1 text-gray-600 rounded"
              phx-click={hide_modal("share-modal")}
            >
              Cancel
            </button>
          </div>
        </.simple_form>
      </main>
      <footer class=" mt-4 flex justify-end"></footer>
    </.modal>
    """
  end
end
