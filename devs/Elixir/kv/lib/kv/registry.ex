defmodule KV.Registry do

    def start_link(module, name) do
        module.start_link(name)
    end

    def create(module, registry, name) do
        module.create(registry, name)
    end

    def lookup(module, registry, name) do
        module.lookup(registry, name)
    end

    def delete(module, registry, name) do
        module.delete(registry, name)
    end

end