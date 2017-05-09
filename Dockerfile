# Debian base-image for the Raspberry Pi 3
# See more about resin base images here: http://docs.resin.io/runtime/resin-base-images/
FROM resin/raspberrypi3-golang

# Disable systemd init system
# ENV INITSYSTEM off

# Use apt-get if you need to install dependencies,
# RUN apt-get update && apt-get install -yq --no-install-recommends \
#     bluez \
#     bluez-firmware \
#     curl \
#     jq \
#     libusb-1.0-0-dev && \
#     apt-get clean && rm -rf /var/lib/apt/lists/*

ENV GOMAXPROCS 1

RUN go install github.com/Sirupsen/logrus
RUN go install github.com/boltdb/bolt
RUN go install github.com/cavaliercoder/grab
RUN go install github.com/currantlabs/ble
RUN go install github.com/gorilla/mux
RUN go install github.com/mholt/archiver
RUN go install github.com/parnurzeal/gorequest
RUN go install github.com/pkg/errors
RUN go install github.com/verybluebot/tarinator-go
RUN go install golang.org/x/net
RUN go install github.com/fredli74/lockfile
RUN go install github.com/kylelemons/gousb

# RUN go get github.com/Masterminds/glide
# WORKDIR /go/src/github.com/resin-io/edge-node-manager
COPY . ./
# RUN glide --debug install
RUN go build

# start.sh will run when container starts up on the device
CMD ["bash", "start.sh"]
