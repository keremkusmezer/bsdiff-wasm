#!/bin/bash

set -o errexit

# Set up environment

ROOT=$PWD
EMCC_FLAGS_DEBUG="-Os -g3"
EMCC_FLAGS_RELEASE="-Oz -flto"

if [ -n $DEBUG ]; then
  CFLAGS="$EMCC_FLAGS_DEBUG"
else
  CFLAGS="$EMCC_FLAGS_RELEASE"
fi

# Apply patches

cd $ROOT/bsdiff
QUILT_PATCHES=$ROOT/bsdiff/debian/patches quilt push -a || true
sed -i -e '/^#include.*cdefs.h/s:^://:' bspatch.c
cd $ROOT

# Build
mkdir -p "$ROOT/dist"

fn_build () {
  emcc $CFLAGS \
    --closure 1 \
    -s WASM=1 \
    -s WASM_BIGINT=1 \
    -s ALLOW_MEMORY_GROWTH=1 \
    -s EXPORTED_RUNTIME_METHODS='["callMain","FS","NODEFS","WORKERFS","ENV"]' \
    -s INCOMING_MODULE_JS_API='["noInitialRun","noFSInit","locateFile","preRun","print","printErr"]' \
    -s NO_INVOKE_RUN \
    -s NO_EXIT_RUNTIME \
    -s NO_DISABLE_EXCEPTION_CATCHING \
    -s MODULARIZE \
    -s EXPORT_ES6 \
    -s EXPORT_NAME=$1 \
    -s FORCE_FILESYSTEM \
    -o "$ROOT/dist/$1.mjs" \
    "$ROOT/bsdiff/$1.c" \
    -Du_char=uint8_t \
    --use-port=bzip2 \
    -lnodefs.js \
    -lworkerfs.js
}

fn_build bsdiff
fn_build bspatch
