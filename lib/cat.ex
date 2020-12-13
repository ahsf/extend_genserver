defmodule Cat do
  use GenServer

  # ---
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def start_meowing() do
    GenServer.cast(__MODULE__, :start_meowing)
  end

  def stop_meowing() do
    GenServer.cast(__MODULE__, :stop_meowing)
  end

  # ---
  @impl true
  def init(state) do
    state =
      state
      |> Animal.init()
      |> Map.put(:meowing, false)

    {:ok, state}
  end

  @impl true
  def handle_cast(:start_meowing, %{running: false} = state) do
    IO.puts("Meeeooooooow!?")
    {:noreply, %{state | meowing: true}}
  end

  @impl true
  def handle_cast(:start_meowing, %{running: true} = state) do
    IO.puts("Meowing? No way. I'm busy running")
    {:noreply, state}
  end

  @impl true
  def handle_cast(:stop_meowing, state) do
    {:noreply, %{state | meowing: false}}
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
