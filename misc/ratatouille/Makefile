.PHONY: gen build

gen:
	protoc -I protobuf --go_out=plugins=grpc:internal/grpc/ratatouille/ protobuf/*.proto

build:
	go mod tidy
	go vet ./...
	go build -o ./service ./cmd/service/
