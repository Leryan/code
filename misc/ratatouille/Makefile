.PHONY: gen vet build

gen:
	protoc -I protobuf --go_out=plugins=grpc:internal/grpc/ratatouille/ protobuf/*.proto

vet:
	go mod tidy
	go vet ./...

build: vet
	go build -o ./service ./cmd/service/
