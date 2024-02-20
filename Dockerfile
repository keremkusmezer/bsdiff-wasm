FROM emscripten/emsdk:3.1.54

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y quilt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
