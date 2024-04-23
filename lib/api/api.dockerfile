# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV DLC_VERSION=0.1.0
ENV BITCOIN_VERSION=27.0

# Install necessary packages
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Bitcoin Core
RUN wget https://bitcoincore.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz \
    && tar -xvf bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz \
    && mv bitcoin-${BITCOIN_VERSION}/bin/* /usr/local/bin/ \
    && rm -rf bitcoin-${BITCOIN_VERSION} bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz

# Install DLC
RUN wget https://github.com/discreetlogcontracts/dlc/releases/download/v${DLC_VERSION}/dlc-linux-${DLC_VERSION}.tar.gz \
    && tar -xvf dlc-linux-${DLC_VERSION}.tar.gz \
    && mv dlc-linux-${DLC_VERSION}/dlc /usr/local/bin/dlc \
    && rm -rf dlc-linux-${DLC_VERSION}.tar.gz dlc-linux-${DLC_VERSION}

# Create a directory for your API code
WORKDIR /app

# Copy your API code into the container
COPY . /app

# Install any dependencies for your API
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port your API will run on
EXPOSE 8000

# Command to run your API
CMD ["python", "app.py"]
