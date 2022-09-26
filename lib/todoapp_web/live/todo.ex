defmodule TodoappWeb.ToDoLive do
  use TodoappWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, tasks: [], newTask: "")}
  end

  def render(assigns) do
    ~L"""
    <div class="bg-purple-900 min-w-full min-h-screen flex flex-col items-center justify-center text-white">
      <h1>To Do List!</h1>

      <form class="flex" phx-submit="add-new-task">
        <input
          class="form-control"
          type="text"
          name="newTask"
          value="<%= @newTask %>"
          autofocus
          placeholder="New Task"
        />
        <button class="ml-2 btn btn-light" type="submit">Add</button>
      </form>

      <ol class="list-decimal my-4">
        <%= for task <- @tasks do %>
          <li>
            <%= task %>
            <button class="btn"
              phx-click="remove-task"
              phx-value-task="<%= task %>"
            >
            X
            </button>
          </li>
        <%= end %>
      </ol>

      <%= if length(@tasks) != 0 do %>
        <button class="btn btn-light" phx-click="remove-all">Remove All Tasks</button>
      <% end %>
    </div>
    """
  end

  def handle_event("add-new-task", %{"newTask" => newTask}, socket) do
    newList = socket.assigns.tasks ++ [newTask]
    {:noreply, assign(socket, tasks: newList)}
  end

  def handle_event("remove-task", %{"task" => task}, socket) do
    newList = Enum.filter(socket.assigns.tasks, fn x -> x != task end)
    {:noreply, assign(socket, tasks: newList)}
  end

  def handle_event("remove-all", _, socket) do
    {:noreply, assign(socket, tasks: [])}
  end

end
