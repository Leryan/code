defmodule KV do
  use Application

  def start(_type, [kvmod]) do
    KV.Supervisor.start_link kvmod
  end
end