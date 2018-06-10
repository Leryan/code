defmodule KV.Registry.ETS do
    require Logger
    use GenServer

    # Client interface

    def start_link(name) do
        GenServer.start_link(__MODULE__, name, name: name)
    end

    def create(registry, name) do
        GenServer.call(registry, {:create, name})
    end

    def lookup(registry, name) do
        case :ets.lookup(registry, name) do
            [{^name, pid}] -> {:ok, pid}
            [] -> :error
        end
    end

    def delete(registry, name) do
        case lookup(registry, name) do
            {:ok, bucket} ->
                KV.Bucket.stop(bucket)
            :error ->
                :ok
        end
    end

    # GenServer callbacks

    def init(table) do
        names = :ets.new(table, [:named_table, read_concurrency: true])
        monitors = %{}
        {:ok, {names, monitors}}
    end

    def handle_call({:create, name}, _from, {names, monitors} = registry) do
        case lookup(names, name) do
            {:ok, bucket} ->
                {:reply, {:ok, bucket}, registry}
            :error ->
                {:ok, bucket} = KV.Bucket.Supervisor.start_bucket
                :ets.insert(names, {name, bucket})
                monitor = Process.monitor(bucket)
                monitors = Map.put(monitors, monitor, name)
                {:reply, {:ok, bucket}, {names, monitors}}
        end
    end

    def handle_info({:DOWN, monitor, :process, _bucket, _reason}, {names, monitors} = _registry) do
        {name, monitors} = Map.pop(monitors, monitor)
        :ets.delete(names, name)
        {:noreply, {names, monitors}}
    end

    def handle_info({tag, _, mtype, _, reason}, registry) do
        Logger.info "#{__MODULE__} event not handled: #{tag} #{mtype} #{reason}"
        {:noreply, registry}
    end
end
