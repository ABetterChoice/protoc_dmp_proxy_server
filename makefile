all: .build

.PHONY: build

.build: .format
	go mod tidy
	protoc --proto_path=$GOPATH/src:${GOPATH}/src/git.code.oa.com/trpcprotocol:. --trpc2grpc_out=require_unimplemented_servers=false:. --go_out=. dmp_proxy_server.proto
	mv -f git.code.oa.com/tencent_abtest/protocol/protoc_dmp_proxy_server/* ./
	rm -rf git.code.oa.com
.format:
	go mod tidy
	gofmt -w .
	goimports -w .
	golint ./...
	go-xray -d .
	gonote .