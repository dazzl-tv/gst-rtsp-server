#!/bin/bash
# 
# Bash script used to build the rtspclientsink gstreamer module
# 
# ./build_gst_library.sh
#
#set -x # mode debug
GST_SOURCE="${PWD}"

echo "--------------------------------------------------"
echo "     BUILD THE RTSPCLIENTSINK GSTREAMER MODULE    "
echo "--------------------------------------------------"

wget --no-check-certificate https://github.com/mesonbuild/meson/releases/download/0.63.0/meson-0.63.0.tar.gz 
tar zxvf meson-0.63.0.tar.gz 
ls -al 
cd /app/gst-rtsp-server 
pwd 
ls -al
python3 /app/meson-0.63.0/meson.py build/ 
cd build/
pwd 
ninja 
ls -al 
tree 
ls -al /app/gst-rtsp-server/build/gst/rtsp-sink/libgstrtspclientsink.so 
file /app/gst-rtsp-server/build/gst/rtsp-sink/libgstrtspclientsink.so 
export GST_PLUGIN_PATH=/app/gst-rtsp-server/build/gst/rtsp-sink/ 
gst-inspect-1.0 rtspclientsink
