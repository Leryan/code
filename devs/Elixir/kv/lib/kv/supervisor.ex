defmodule KV.Supervisor do
    use Supervisor

    def start_link(kvmod) do
        Supervisor.start_link(__MODULE__, kvmod)
    end

    def init(kvmod) do
        children = [
            worker(KV.Registry, [kvmod, KV.Registry]),
            supervisor(KV.Bucket.Supervisor, [])
        ]

        supervise(children, strategy: :rest_for_one)
    end
end