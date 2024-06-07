# syntax=docker/dockerfile:1
FROM --platform=amd64 ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y wget zip cmake libssl-dev libusb-1.0-0-dev build-essential git

# nRF command line tools
RUN apt-get install -y \
    && wget https://nsscprodmedia.blob.core.windows.net/prod/software-and-other-downloads/desktop-software/nrf-command-line-tools/sw/versions-10-x-x/10-22-1/nrf-command-line-tools_10.22.1_amd64.deb \
    && dpkg -i nrf-command-line-tools_10.22.1_amd64.deb \
    && rm nrf-command-line-tools_10.22.1_amd64.deb

# nrfutil
RUN wget https://developer.nordicsemi.com/.pc-tools/nrfutil/x64-linux/nrfutil -O /usr/local/bin/nrfutil \
    && chmod +x /usr/local/bin/nrfutil
RUN nrfutil install nrf5sdk-tools
RUN nrfutil list

# clean up apt lists
RUN rm -rf /var/lib/apt/lists/*
