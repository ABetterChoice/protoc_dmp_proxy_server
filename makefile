all: .build

.PHONY: build

.build: .format
	go mod tidy
	protoc --proto_path=$GOPATH/src:${GOPATH}/src/git.code.oa.com/trpcprotocol:. --trpc2grpc_out=require_unimplemented_servers=false:. --go_out=. dmp_proxy_server.proto
	mv -f git.tencent.com/abetterchoice/protocol/protoc_dmp_proxy_server/* ./
	rm -rf git.tencent.com
.format:
	go mod tidy
	gofmt -w .
	goimports -w .
	golint ./...
	gonote .