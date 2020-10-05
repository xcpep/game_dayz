# ----------------------------------
# Pterodactyl DayZ Standalone Base Image
# Author: https://github.com/xcpep
# ----------------------------------
FROM        ubuntu:20.04

LABEL       author="xcpep" maintainer="admin@xcpep.io"

ENV         DEBIAN_FRONTEND noninteractive
ENV         APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Install Dependencies
RUN         dpkg --add-architecture i386 \
            && apt-get update \
            && apt-get upgrade -y \
            && apt-get install -y apt-utils

RUN         apt-get update \
            && apt-get upgrade -y \
            && apt-get install -y tar curl gcc g++ lib32gcc1 libgcc1 libcurl4-gnutls-dev:i386 libcurl4:i386 libtinfo5:i386 lib32z1 lib32stdc++6 libncurses5:i386 libcurl3-gnutls:i386 iproute2 gdb libsdl1.2debian libfontconfig telnet net-tools netcat wget gnupg2 apt-transport-https \
            && useradd -m -d /home/container container

RUN         dpkg --add-architecture i386 \
            && apt install -y wine64 wine32

USER        container
ENV         HOME /home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]