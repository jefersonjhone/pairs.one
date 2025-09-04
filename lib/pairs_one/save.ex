defmodule PairsOne.InMemoryStore do
  use GenServer

  # Client API

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def exists(_conn, key) do
    GenServer.call(__MODULE__, {:exists?, key})
  end

  def get(_conn, key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def put(_conn, key, value) do
    GenServer.cast(__MODULE__, {:put, key, value})
  end

  def delete(_conn, key) do
    GenServer.cast(__MODULE__, {:delete, key})
  end


  def setex(_conn, key, seconds, value) do
    GenServer.call(__MODULE__, {:setex, key, seconds, value})
  end


  # Server callbacks

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:exists?, key}, _from, state) do
    #{:reply, Map.has_key?(state, key), state}
    exists = if Map.has_key?(state, key), do: 1, else: 0
    {:reply, exists, state}
  end

  def handle_call({:setex, key, seconds, value}, _from, state) do
    # Store the key with the value
    new_state = Map.put(state, key, value)

    # Schedule removal of the key after `seconds`
    Process.send_after(self(), {:expire_key, key}, seconds * 1000)

    {:reply, :ok, new_state}
  end

  @impl true
  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end

  @impl true
  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  @impl true
  def handle_cast({:delete, key}, state) do
    {:noreply, Map.delete(state, key)}
  end
end
