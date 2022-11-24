NAME = wasmedge-rootfs-mounts-demo
IMAGE = $(NAME)
WASM = $(NAME).wasm
INSTANCE = $(NAME)-run
TARBALL = $(NAME).tar

.PHONY: init
init:
	rustup target add wasm32-wasi
	rustup update

.PHONY: build
build:
	cargo build --release --target wasm32-wasi

.PHONY: image
image: build
	docker build -f Dockerfile . -t $(IMAGE)

.PHONY: docker-run
demo-docker: image
	docker run --name $(INSTANCE) --mount source=${PWD}/src,target=/mnt --runtime=io.containerd.wasmedge.v1 --platform wasi/wasm32 $(IMAGE)
	docker export $(INSTANCE) -o $(TARBALL)
	tar -tvf $(TARBALL)
	docker rm $(INSTANCE)
	rm $(TARBALL)

.PHONY: docker-run
demo-wasmedge: build
	wasmedge --dir /:${PWD}/target/wasm32-wasi/release target/wasm32-wasi/release/$(WASM)
