defmodule Cat do
  use GenServer

  # ---
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def start_miaowing() do
    GenServer.cast(__MODULE__, :start_miaowing)
  end

  def stop_miaowing() do
    GenServer.cast(__MODULE__, :stop_miaowing)
  end

  # ---
  @impl true
  def init(state) do
    state =
      state
      |> Animal.init()
      |> Map.put(:miaowing, false)

    {:ok, state}
  end

  @impl true
  def handle_cast(:start_miaowing, %{running: false} = state) do
    IO.puts("Meeeooooooow!?")
    {:noreply, %{state | miaowing: true}}
  end

  @impl true
  def handle_cast(:start_miaowing, %{running: true} = state) do
    IO.puts("Meowing? No way. I'm busy running")
    {:noreply, state}
  end

  @impl true
  def handle_cast(:stop_miaowing, state) do
    {:noreply, %{state | miaowing: false}}
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
