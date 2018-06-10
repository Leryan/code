defmodule KV.RegistryTest do
    use ExUnit.Case

    @kvmod KV.Registry.ETS

    setup context do
        case @kvmod do
            KV.Registry.ETS ->
                {:ok, _} = KV.Registry.start_link(@kvmod, context.test)
                {:ok, registry: context.test}
            KV.Registry.Map ->
                {:ok, registry} = KV.Registry.start_link(@kvmod, context.test)
                {:ok, registry: registry}
        end
    end

    test "register bucket", %{registry: registry} do
        assert {:ok, pidc} = KV.Registry.create(@kvmod, registry, "buk")
        assert {:ok, pidl} = KV.Registry.lookup(@kvmod, registry, "buk")

        assert pidc == pidl
    end

    test "automatic bucket cleanup on normal stop", %{registry: registry} do
        assert {:ok, bucket} = KV.Registry.create(@kvmod, registry, "buk")

        KV.Bucket.stop(bucket)

        _ = KV.Registry.create(@kvmod, registry, "bogus")
        assert :error == KV.Registry.lookup(@kvmod, registry, "buk")
    end

    test "automatic bucket cleanup on shutdown", %{registry: registry} do
        assert {:ok, bucket} = KV.Registry.create(@kvmod, registry, "buk")

        # monitor so we can catch :DOWN signal
        monitor = Process.monitor(bucket)
        # because we start buckets directly with start_link,
        # (no supervisor used) the registry will also crash.
        # we have to use a supervisor to start buckets.
        Process.exit(bucket, :shutdown)

        assert_receive {:DOWN, ^monitor, _, _, _}

        _ = KV.Registry.create(@kvmod, registry, "bogus")
        assert :error == KV.Registry.lookup(@kvmod, registry, "buk")
    end

    test "manual bucket cleanup", %{registry: registry} do
        assert {:ok, _bucket} = KV.Registry.create(@kvmod, registry, "buk")
        assert :ok = KV.Registry.delete(@kvmod, registry, "buk")

        _ = KV.Registry.create(@kvmod, registry, "bogus")
        assert :error == KV.Registry.lookup(@kvmod, registry, "buk")
    end

end