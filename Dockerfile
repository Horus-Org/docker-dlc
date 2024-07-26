# Use Rust base image
FROM rust:1.80.0 as rust

# Use Rust DLC & Lightning base image

FROM dlc:0.5.0 as dlc
FROM lightning:0.0.123 as lightning

# Use Phython DLC base image

FROM cfd-dlc:0.0.8 as cfd-dlc

# Use Docker DLC 

FROM docker-dlc:1.0.0 as docker-dlc

# Use Python base image
FROM python:3.12-slim

# Define the base image for the build stage
FROM debian:stable-slim as builder

# Set ARGs for build-time variables
ARG VERSION=27.0
ARG REPO_URL=https://github.com/bitcoin/bitcoin.git
ARG REPO_URL=https://github.com/bitcoinknots/bitcoin.git
ARG VERSION=27.0.knots20240513
ARG DLC_VERSION=0.1.0

# Install build dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  automake \
  pkg-config \
  libtool \
  autotools-dev \
  bsdmainutils \
  python3 \
  git \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-thread-dev \
  libevent-dev \
  libsqlite3-dev \
  libdb-dev \
  libdb++-dev \
  libzmq3-dev && \
  rm -rf /var/lib/apt/lists/*

# Clone the repository at the specified version
RUN git clone --branch $VERSION $REPO_URL /bitcoin-source
WORKDIR /bitcoin-source

# Build the dependencies and configure settings
RUN ./autogen.sh && \
    ./configure \
    CXXFLAGS="-O2" \
    --disable-man \
    --disable-shared \
    --disable-ccache \
    --disable-tests \
    --enable-static \
    --enable-reduce-exports \
    --without-gui \
    --without-libs \
    --with-utils \
    --with-zmq \
    --with-sqlite=yes \
    --with-incompatible-bdb && \
    make -j$(nproc)

# Install the binaries to a separate directory
RUN make install DESTDIR=/bitcoin-dist

# Start the final stage for a smaller, cleaner image
FROM debian:stable-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
  libboost-system-dev \
  libboost-filesystem-dev \
  libboost-thread-dev \
  libevent-dev \
  libzmq3-dev \
  libsqlite3-dev \
  libdb-dev \
  libdb++-dev && \
  rm -rf /var/lib/apt/lists/* \
  && useradd -ms /bin/bash bitcoin

USER bitcoin
WORKDIR /home/bitcoin

# Copy the built binaries from the builder stage
COPY --from=builder /bitcoin-dist/usr/local /usr/local

# Prepare the data directory
RUN mkdir -p "$HOME/.bitcoin/"

# Set the entrypoint to the bitcoind daemon
ENTRYPOINT ["bitcoind"]

# Set work directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the DLC logic file into the container
COPY pypi-dlc.py .

# Run the DLC logic script
CMD ["python", "pypi-dlc.py"]
