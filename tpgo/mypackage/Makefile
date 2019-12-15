init:
	go mod download
build:
	go build .
run: build
	./mypackage
test:
	go test ./...
bench:
	go test -bench=. -benchmem ./...
convey:
	goconvey server