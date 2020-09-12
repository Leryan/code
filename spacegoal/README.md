# spacegoal

[WIP] Spacewalk brought to Go

## RPC from CLI

```
spacegoal -U "https://spacewalk.server.local/rpc/api/" -u admin -p admin -m "channel.listAllChannels"
spacegoal -U "https://spacewalk.server.local/rpc/api/" -u admin -p admin -m "channel.software.listAllPackages" -j '["testlabel"]'
```

## TTD - Things To Do

 * Implement the secret project. Dis iz a ziicret my good'o'd'man.
