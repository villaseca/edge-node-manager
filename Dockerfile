# Debian base-image for the Raspberry Pi 3
# See more about resin base images here: http://docs.resin.io/runtime/resin-base-images/
FROM resin/raspberrypi3-golang:latest

# Disable systemd init system
ENV INITSYSTEM off

# Use apt-get if you need to install dependencies,
RUN apt-get update && apt-get install -yq --no-install-recommends \
    bluez \
    bluez-firmware \
    curl \
    jq z
    libusb-1.0-0-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN go get github.com/Masterminds/glide
WORKDIR /go/src/github.com/resin-io/edge-node-manager
COPY . ./
RUN glide install
RUN go build

# start.sh will run when container starts up on the device
CMD ["bash", "start.sh"]
