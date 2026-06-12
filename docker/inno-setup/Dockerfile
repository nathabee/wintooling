FROM debian:12-slim

ARG INNO_SETUP_VERSION=6.2.2

ENV DEBIAN_FRONTEND=noninteractive
ENV WINEDEBUG=-all

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        unzip \
        wine \
        wine32 \
        wine64 \
        xvfb \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/inno-setup \
    && curl -fsSL "https://files.jrsoftware.org/is/6/innosetup-${INNO_SETUP_VERSION}.exe" -o /tmp/innosetup.exe \
    && xvfb-run -a wine /tmp/innosetup.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /DIR=C:\\InnoSetup \
    && rm -f /tmp/innosetup.exe

COPY iscc /usr/local/bin/iscc

RUN chmod +x /usr/local/bin/iscc

WORKDIR /work

ENTRYPOINT ["iscc"]
