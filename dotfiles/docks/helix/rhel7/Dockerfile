FROM registry.access.redhat.com/ubi7/ubi as rhel7

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.68.2

RUN set -eux; \
    yum install -y \
        ca-certificates \
				git \
        gcc \
        libc6-dev \
        wget 
ENV rustArch='x86_64-unknown-linux-gnu' 
RUN rustupSha256='bb31eaf643926b2ee9f4d8d6fc0e2835e03c0a60f34d324048aa194f0b29a71c' ; \
    url="https://static.rust-lang.org/rustup/archive/1.25.2/${rustArch}/rustup-init"; \
    wget "$url"; \
    echo "${rustupSha256} *rustup-init" | sha256sum -c -; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host ${rustArch}; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version; 


FROM rhel7 as builder

RUN mkdir /src; cd /src; git clone --depth 1 https://github.com/helix-editor/helix.git /src/helix
WORKDIR /src/helix
RUN cargo install --path helix-term --locked 
