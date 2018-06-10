defmodule KV.SupervisorTest do
    use ExUnit.Case

    test "start sup" do
        # don't do since it's started by the application
        #_ = KV.Supervisor.start_link
    end
end