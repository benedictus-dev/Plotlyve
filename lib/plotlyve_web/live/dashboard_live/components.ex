defmodule DashboardLive.Components do
  use Phoenix.Component
  import PlotlyveWeb.CoreComponents
  alias Phoenix.LiveView.JS

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
    ~H"""
    <section class=" px-5 mt-7">
      <header class=" flex justify-between ">
        <h2>Plots</h2>
        <.create_plot />
      </header>
      <%!--
      <.simple_table rows={[%{name: "Jane", age: "34"}, %{name: "Bob", age: "51"}]}>
        <:column :let={user} label="Name">
          <%= user.name %>
        </:column>
        <:column :let={user} label="Age">
          <%= user.age %>
        </:column>
      </.simple_table> --%>
    </section>
    """
  end

  # attr :datasetname, :string, default: "Iris"
  # attr :expression, :string, default: "SepalWidth"

  def data_form(assigns) do
    ~H"""
    <%!-- <form class="bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
      <div class="mb-4">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="datasetname">
          Dataset name
        </label>
        <input
          class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
          id="datasetname"
          type="text"
          value={@datasetname}
        />
      </div>
      <div class="mb-6">
        <label class="block text-gray-700 text-sm font-bold mb-2" for="expression">
          Expression
        </label>
        <input
          class="shadow appearance-none border  rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline"
          id="expression"
          type="text"
          value={@expression}
        />
      </div>
      <div class="flex items-center justify-end">
        <button
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
          type="button"
        >
          Save
        </button>

      </div>
    </form> --%>
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
end
