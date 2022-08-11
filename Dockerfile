FROM ubuntu:20.04

LABEL maintainer="Thierry GAYET <thierry.gayet@dazzl.tv>"
LABEL description="Build the rtspclientsink gstreamer's module"

WORKDIR /app

COPY ./ /app/gst-rtsp-server/
#COPY ./.packagecloud /root/

ENV DEBIAN_FRONTEND=noninteractive
#ENV PACKAGECLOUD_TOKEN=$PACKAGECLOUD_TOKEN

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN echo PACKAGECLOUD_TOKEN=$PACKAGECLOUD_TOKEN
RUN env
#RUN echo secrets_PACKAGECLOUD_TOKEN =${{ secrets.PACKAGECLOUD_TOKEN }}

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
    ruby-full \
    ruby \
    ruby2.7-dev \
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
  && cd /app/ \
  && /app/gst-rtsp-server/build_gst_library.sh \
  && cd /app/gst-rtsp-server/ \
  && /app/gst-rtsp-server/mk_debian_package.sh "1.16.2" \
  && id \
  && /app/gst-rtsp-server/push-to-repository.sh "1.16.2"


