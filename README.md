# bsdiff-wasm

`bsdiff/bspatch` compiled to WebAssembly.

# Build

```sh
docker build -t bsdiff-wasm-build .
docker run --rm -v $PWD:/src -u $(id -u):$(id -g) -w /src bsdiff-wasm-build /bin/bash build.sh
```
