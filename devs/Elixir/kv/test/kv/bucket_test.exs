defmodule KV.BucketTest do
    use ExUnit.Case

    setup do
        {:ok, bucket} = KV.Bucket.start_link
        {:ok, bucket: bucket}
    end

    test "set value", %{bucket: bucket} do
        KV.Bucket.set(bucket, "key", "value")
        KV.Bucket.set(bucket, "key2", "value2")

        assert KV.Bucket.get(bucket, "key") == "value"
        assert KV.Bucket.get(bucket, "key2") == "value2"
    end

    test "delete key", %{bucket: bucket} do
        KV.Bucket.set(bucket, "key", "value")
        KV.Bucket.del(bucket, "key")
    end

end