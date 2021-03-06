# Debian base-image for the Raspberry Pi 3
# See more about resin base images here: http://docs.resin.io/runtime/resin-base-images/
FROM resin/raspberrypi3-debian

# Disable systemd init system
ENV INITSYSTEM off

# Set our working directory
WORKDIR /usr/src/app

# Use apt-get if you need to install dependencies,
RUN apt-get update && apt-get install -yq --no-install-recommends \
    bluez \
    bluez-firmware \
    curl \
    jq \
    nmap && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Get the edge-node-manager binary, rename and make executable
RUN TAG=$(curl https://api.github.com/repos/resin-io/edge-node-manager/releases/latest -s | jq .tag_name -r) && \
    echo "Pulling $TAG of the edge-node-manager binary" && \
    curl -k -O https://resin-production-downloads.s3.amazonaws.com/edge-node-manager/$TAG/edge-node-manager-$TAG-linux-arm && \
    mv edge-node-manager-$TAG-linux-arm edge-node-manager && \
    chmod +x edge-node-manager

# Alternatively cross-compile the binary locally (env GOOS=linux GOARCH=arm go build)
# and copy it into the working directory - good for development
# COPY edge-node-manager ./

# The edge-node-manager will run when container starts up on the device
CMD ["./edge-node-manager"]
