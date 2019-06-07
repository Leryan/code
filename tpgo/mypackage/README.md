# Setup

Be sure that `$PATH` has `$GOPATH/bin`.

```
# run this command from outside the sources folder or it will modify go.mod and go.sum
go get -u github.com/smartystreets/goconvey
```

### Launch automated tests and webui of goconvey

```
make convey
```
