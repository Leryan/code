defmodule KV.Registry.Map do
    require Logger
    use GenServer

    # Client interface

    def start_link(name) do
        GenServer.start_link(__MODULE__, :ok, name: name)
    end

    def create(registry, name) do
        GenServer.call(registry, {:create, name})
    end

    def lookup(registry, name) do
        GenServer.call(registry, {:lookup, name})
    end

    def delete(registry, name) do
        GenServer.call(registry, {:delete, name})
    end

    # GenServer callbacks

    def init(:ok) do
        names = %{}
        monitors = %{}
        {:ok, {names, monitors}}
    end

    def handle_call({:create, name}, _from, {names, monitors} = registry) do
        case Map.fetch(names, name) do
            {:ok, bucket} ->
                {:reply, {:ok, bucket}, registry}
            :error ->
                {:ok, bucket} = KV.Bucket.Supervisor.start_bucket
                names = Map.put(names, name, bucket)
                monitor = Process.monitor(bucket)
                monitors = Map.put(monitors, monitor, name)
                {:reply, {:ok, bucket}, {names, monitors}}
        end
    end

    def handle_call({:lookup, name}, _from, {names, _monitors} = registry) do
        {:reply, Map.fetch(names, name), registry}
    end

    def handle_call({:delete, name}, _from, {names, _monitors} = registry) do
        case Map.fetch(names, name) do
            {:ok, bucket} ->
                :ok = KV.Bucket.stop(bucket)
                {:reply, :ok, registry}
            _ ->
                {:reply, :ok, registry}
        end
    end

    def handle_info({:DOWN, monitor, :process, _bucket, _reason}, {names, monitors} = _registry) do
        {name, monitors} = Map.pop(monitors, monitor)
        names = Map.delete(names, name)
        {:noreply, {names, monitors}}
    end

    def handle_info({tag, _, mtype, _, reason}, registry) do
        Logger.info "#{__MODULE__} event not handled: #{tag} #{mtype} #{reason}"
        {:noreply, registry}
    end
end
