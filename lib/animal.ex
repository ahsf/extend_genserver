defmodule Animal do
  # ---
  def start_running(pid) do
    GenServer.cast(pid, :start_running)
  end

  def stop_running(pid) do
    GenServer.cast(pid, :stop_running)
  end

  def get_state(pid) do
    GenServer.call(pid, :get_state)
  end

  # ---
  def handle_cast(:start_running, state) do
    {:noreply, %{state | running: true}}
  end

  def handle_cast(:stop_running, state) do
    {:noreply, %{state | running: false}}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  # ---
  def init(state) do
    Map.put(state, :running, false)
  end
end
