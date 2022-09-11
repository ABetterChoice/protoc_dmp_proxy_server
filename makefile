all: .build

.PHONY: build

.build: .format
	go mod tidy
	protoc --proto_path=$GOPATH/src:${GOPATH}/src/git.code.oa.com/trpcprotocol:. --trpc2grpc_out=require_unimplemented_servers=false:. --go_out=. dmp_proxy_server.proto

.format:
	go mod tidy
	gofmt -w .
	goimports -w .
	golint ./...
	go-xray -d .
	gonote .