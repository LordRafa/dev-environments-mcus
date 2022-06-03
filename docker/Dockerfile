FROM ubuntu:22.04

MAINTAINER Rafael Waldo Delgado Doblas

# Initial Setup
ARG UID=1000
ARG GID=1000
ARG USER="vscode"
ENV APP_HOME="/App_Home"

ENV DEBIAN_FRONTEND="noninteractive"
ENV PICO_SDK_PATH="/tmp/pico-sdk"

# Setting up the user
RUN ln -s "$APP_HOME" "/home/$USER"

RUN groupadd -g "$GID" -r "$USER"
RUN useradd -u "$UID" -g "$GID" -r "$USER" -s /bin/bash

# Provisioning required configs and executables
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 755 /usr/local/bin/entrypoint.sh

RUN apt update; apt -y upgrade \
    apt install -y git curl tio python3 git cmake gcc-arm-none-eabi gcc g++ \
                   gdb-multiarch automake autoconf build-essential texinfo \ 
                   libtool libftdi-dev libusb-1.0-0-dev pkg-config libgpiod-dev \
                   python3-tk python3-distutils python3.10-venv \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Pico SDK
ENV PICO_SDK_PATH="/pico/sdk"
ENV PICO_EXAMPLES_PATH="/pico/examples"
ENV PICO_EXTRAS_PATH="/pico/extras"
ENV PICO_PLAYGROUND_PATH="/pico/playground"
ENV PATH="$PATH:/pico/pico-project-generator"

RUN git clone "https://github.com/raspberrypi/pico-project-generator" "/pico/pico-project-generator"

RUN git clone "https://github.com/raspberrypi/pico-sdk.git" "/pico/sdk" && \
    cd "/pico/sdk" && git submodule update --init

RUN git clone "https://github.com/raspberrypi/pico-extras.git" "/pico/extras" && \
    cd "/pico/extras" && git submodule update --init

RUN git clone "https://github.com/raspberrypi/picoprobe.git" "/pico/picoprobe" && \
    cd "/pico/picoprobe" && git submodule update --init

RUN git clone "https://github.com/raspberrypi/pico-examples.git" "/pico/examples" && \
    cd "/pico/examples" && git submodule update --init

RUN git clone "https://github.com/raspberrypi/pico-playground.git" "/pico/playground" && \
    cd "/pico/playground" && git submodule update --init

RUN git clone https://github.com/raspberrypi/picotool.git /tmp/picotool && \
    cd /tmp/picotool && cmake -S . -B build && cmake --build build -j 4 && cmake --install build && rm -rf /tmp/picotool

RUN git clone https://github.com/raspberrypi/openocd.git -b rp2040 --depth=1 /tmp/openocd && \
    cd /tmp/openocd && \
    ./bootstrap && ./configure --enable-ftdi --enable-sysfsgpio --enable-bcm2835gpio --enable-picoprobe && \    
    make -j4 && make install && rm -rf /tmp/openocd

# Arduino Cli
RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR=/usr/local/bin sh

# J-Link
ENV PATH="$PATH:$APP_HOME/JLINK"

# Setting up entry point
USER "$USER"
VOLUME "$APP_HOME"
VOLUME "$APP_HOME/mcu-projects"
WORKDIR "/home/$USER"
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]

