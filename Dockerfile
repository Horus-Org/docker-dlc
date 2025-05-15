# Use Rust base image
FROM rust:1.87.0 as rust

# Use Rust DLC & Lightning base image
FROM dlc:0.7.1 as dlc
FROM lightning:24.11.1 as lightning
FROM eclair:0.12.0 as eclair
FROM lnd:0.18.5 as lnd

# Use Phython DLC base image
FROM cfd-dlc:0.0.8 as cfd-dlc

# Use Docker DLC 
FROM docker-dlc:1.0.9 as docker-dlcc

# Use Python base image
FROM python:3.13-slim

# Define the base image for the build stage
FROM debian:stable-slim as builder

# Set ARGs for build-time variables
ARG VERSION=29.0
ARG REPO_URL=https://github.com/bitcoin/bitcoin.git
ARG REPO_URL=https://github.com/bitcoinknots/bitcoin
ARG VERSION_KNOTS=28.1.knots20250305
ARG DLC_VERSION=0.1.0-beta

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
RUN git clone https://github.com/bitcoin/bitcoin.git /bitcoin-source

USER bitcoin
WORKDIR /home/bitcoind


# Set the entrypoint to the bitcoind daemon
ENTRYPOINT ["bitcoind"]

# Set work directory
WORKDIR /app

# Copy requirements file
COPY requirements.txt .

# Copy the DLC logic file into the container
COPY pypi-dlc.py .

# Run the DLC logic script
CMD ["python", "pypi-dlc.py"]
