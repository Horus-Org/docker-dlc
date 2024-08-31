# Run Docker DLC with Rust DLC and CFD-DLC

## Prerequisites

Before starting, ensure that the following are installed and configured on your system:

- **Bitcoin Core**: Ensure Bitcoin Core is installed and running. Synchronize it with the network.
- **Python**: Install Python (version 3.x).
- **Docker**: Install Docker and ensure it's running.
- **CFD-DLC**: Clone and set up the CFD-DLC repository.
- **Rust DLC**: Clone and set up the Rust DLC repository.
- **Rust**: Install the Rust programming language.

### Step 1: Install Docker

If Docker is not installed, you can install it using the following commands based on your operating system.

#### On Ubuntu:
```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

Install Docker Engine:
```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

#### On MacOS:
```bash
brew install --cask docker
```

### Step 2: Clone the Repositories

Clone the necessary repositories for CFD-DLC and Rust DLC.

#### CFD-DLC:
```bash
git clone https://github.com/p2pderivatives/cfd-dlc.git
cd cfd-dlc
```

#### Rust DLC:
```bash
git clone https://github.com/p2pderivatives/rust-dlc.git
cd your-rust-dlc-repo
```

### Step 3: Create Dockerfile

Create a `Dockerfile` in the root of your Rust DLC project directory.

```Dockerfile
# Use an official Rust runtime as a parent image
FROM rust:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    bitcoin-core \
    && rm -rf /var/lib/apt/lists/*

# Clone and build CFD-DLC
RUN git clone https://github.com/p2pderivatives/cfd-dlc.git /cfd-dlc
WORKDIR /cfd-dlc
RUN ./configure && make && make install

# Clone and build Rust DLC
RUN git clone https://github.com/your-rust-dlc-repo.git /rust-dlc
WORKDIR /rust-dlc
RUN cargo build --release

# Run the Rust DLC binary
CMD ["./target/release/your-rust-dlc-binary"]
```

### Step 4: Build and Run Docker Container

Build the Docker image:

```bash
docker build -t dlc-image .
```

Run the Docker container:

```bash
docker run -d --name dlc-container dlc-image
```

### Step 5: Access the Container

To access the running container:

```bash
docker exec -it dlc-container /bin/bash
```

Now you can interact with your Rust DLC and CFD-DLC setups inside the Docker container.

### Step 6: Verify Setup

Once inside the container, you can verify that both Rust DLC and CFD-DLC are working correctly:

```bash
cd /rust-dlc
./target/release/your-rust-dlc-binary --help

cd /cfd-dlc
./cfd-dlc-binary --help
```
