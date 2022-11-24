FROM scratch
COPY target/wasm32-wasi/release/wasmedge-rootfs-mounts-demo.wasm /
COPY target/wasm32-wasi/release/ /test-dir

ENTRYPOINT [ "/wasmedge-rootfs-mounts-demo.wasm" ]
