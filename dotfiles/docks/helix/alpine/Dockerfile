FROM rust:alpine as builder

#RUN rustup component add rust-std-x86_64-unknown-linux-musl
RUN apk add git gcc libc-dev
RUN mkdir /src; cd /src; git clone --depth 1 https://github.com/helix-editor/helix.git /src/helix
WORKDIR /src/helix
RUN env RUSTFLAGS="-C target-feature=-crt-static" cargo install --path helix-term --locked --target x86_64-unknown-linux-musl 
