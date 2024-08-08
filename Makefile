build_dir = build

.PHONY: all clean build_aws build_azure build_gcp

all: clean $(build_dir) build_aws build_azure build_gcp

clean:
	rm -rf $(build_dir)
	mkdir -p $(build_dir)

build_aws:
	$(MAKE) -C aws build
	cp aws/build/kube-client-go-aws-credential-exec-plugin-darwin $(build_dir)/
	cp aws/build/kube-client-go-aws-credential-exec-plugin-darwin-amd64 $(build_dir)/
	cp aws/build/kube-client-go-aws-credential-exec-plugin-darwin-arm64 $(build_dir)/
	cp aws/build/kube-client-go-aws-credential-exec-plugin-linux $(build_dir)/

build_azure:
	$(MAKE) -C azure build
	cp azure/build/kube-client-go-azure-credential-exec-plugin-darwin $(build_dir)/
	cp azure/build/kube-client-go-azure-credential-exec-plugin-darwin-amd64 $(build_dir)/
	cp azure/build/kube-client-go-azure-credential-exec-plugin-darwin-arm64 $(build_dir)/
	cp azure/build/kube-client-go-azure-credential-exec-plugin-linux $(build_dir)/

build_gcp:
	$(MAKE) -C gcp build
	cp gcp/build/kube-client-go-gcp-credential-exec-plugin-darwin $(build_dir)/
	cp gcp/build/kube-client-go-gcp-credential-exec-plugin-darwin-amd64 $(build_dir)/
	cp gcp/build/kube-client-go-gcp-credential-exec-plugin-darwin-arm64 $(build_dir)/
	cp gcp/build/kube-client-go-gcp-credential-exec-plugin-linux $(build_dir)/
