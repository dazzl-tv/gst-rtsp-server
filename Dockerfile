FROM ubuntu:20.04

LABEL maintainer="Thierry GAYET <thierry.gayet@dazzl.tv>"
LABEL description="Build the rtspclientsink gstreamer's module"

WORKDIR /app

COPY ./ /app/gst-rtsp-server/

ENV DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
  && apt-get -y install --no-install-recommends \
    pkg-config \
    build-essential \
    libnss3 \
    libnice10 \
    iproute2 \
    ninja-build \
    wget \
    tree \
    file \
    python3 \
    gstreamer1.0-tools \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    libgstreamer1.0-dev \
    libgstreamermm-1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libgstreamer-plugins-bad1.0-dev \
    libgstreamer-plugins-good1.0-dev \
    libcgroup-dev \
    libcgroup1 \
    libxcomposite1 \
    libxtst6 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libatspi2.0-0 \
    libcups2-dev \
  && pwd \
  && wget --no-check-certificate https://github.com/mesonbuild/meson/releases/download/0.63.0/meson-0.63.0.tar.gz \
  && tar zxvf meson-0.63.0.tar.gz \
  && ls -al \
  && cd /app/gst-rtsp-server \
  && pwd \
  && ls -al \
  && python3 /app/meson-0.63.0/meson.py build/ \
  && cd build/ \
  && pwd \
  && ninja \
  && ls -al \
  && tree \
  && ls -al /app/gst-rtsp-server/build/gst/rtsp-sink/libgstrtspclientsink.so \
  && file /app/gst-rtsp-server/build/gst/rtsp-sink/libgstrtspclientsink.so \
  && export GST_PLUGIN_PATH=/app/gst-rtsp-server/build/gst/rtsp-sink/ \
  && gst-inspect-1.0 rtspclientsink

