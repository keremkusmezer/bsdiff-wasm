# bsdiff-wasm

`bsdiff/bspatch` compiled to WebAssembly.

This is a rebuild of [bsdiff (4.3-23)](https://packages.debian.org/en/bookworm/bsdiff) maintained by debian and is fully compatible.
The original was developed by Colin Percival. Please see http://www.daemonology.net/bsdiff/.

# Build

```sh
docker build -t bsdiff-wasm-build .
docker run --rm -v $PWD:/src -u $(id -u):$(id -g) -w /src bsdiff-wasm-build /bin/bash build.sh
```
