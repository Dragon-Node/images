# ----------------------------------
# Environment: ubuntu
# Minimum Panel Version: 0.7.X
# ----------------------------------
FROM    node:14-buster-slim

LABEL   author="paz" maintainer="paz@paz.yt"

ENV     DEBIAN_FRONTEND noninteractive

RUN useradd -m -d /home/container -s /bin/bash container

RUN apt install -y gcc g++ libgcc1 lib32gcc1 gdb libc6 git wget curl tar zip unzip binutils xz-utils liblzo2-2 cabextract iproute2 net-tools netcat telnet libatomic1 libsdl1.2debian libsdl2-2.0-0 \
    libfontconfig libicu63 icu-devtools libunwind8 libssl-dev sqlite3 libsqlite3-dev libmariadbclient-dev libduktape203 locales ffmpeg gnupg2 apt-transport-https software-properties-common ca-certificates tzdata

RUN update-locale lang=en_US.UTF-8 \
 && dpkg-reconfigure --frontend noninteractive locales

RUN     apt update -y \
        && apt upgrade -y \
        && wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
        && dpkg -i packages-microsoft-prod.deb \
        && apt update -y \
        && apt install -y dotnet-sdk-5.0 aspnetcore-runtime-5.0 libgdiplus \
        && apt -y install ffmpeg iproute2 git sqlite3 python3 ca-certificates dnsutils build-essential

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]
