defmodule Dog do
  use GenServer

  # ---
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def start_barking() do
    GenServer.cast(__MODULE__, :start_barking)
  end

  def stop_barking() do
    GenServer.cast(__MODULE__, :stop_barking)
  end

  # ---
  @impl true
  def init(state) do
    state =
      state
      |> Animal.init()
      |> Map.put(:barking, false)

    {:ok, state}
  end

  @impl true
  def handle_cast(:start_barking, state) do
    IO.puts("Woof! Woof!")
    {:noreply, %{state | barking: true}}
  end

  @impl true
  def handle_cast(:stop_barking, state) do
    {:noreply, %{state | barking: false}}
  end

  # --- super
  @impl true
  def handle_cast(command, state) do
    Animal.handle_cast(command, state)
  end

  @impl true
  def handle_call(command, from, state) do
    Animal.handle_call(command, from, state)
  end
end
