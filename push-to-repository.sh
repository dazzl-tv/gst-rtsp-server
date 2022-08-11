#!/bin/bash
# 
# Bash script used to package the gstreamer rtspclientsink module as debian one
# 
# ./mk_debian_package.sh "1.16.2"
#
# https://packagecloud.io/l/cli
# https://stackoverflow.com/questions/20559255/error-while-installing-json-gem-mkmf-rb-cant-find-header-files-for-ruby
#
#set -x # mode debug

echo "PACKAGECLOUD_TOKEN=${PACKAGECLOUD_TOKEN}"

GST_SOURCE="${PWD}"
PACKAGE_NAME="gst-1.0-rtspclientsink-${1}.deb"

echo "------------------------------------------"
echo " PUSHING DEBIAN PACKAGE TO PACKAGECLOUD "
echo "------------------------------------------"

gem install package_cloud

# package_cloud push <username>/<reponame>/any/any <deb file>
# user/repo[/distro/version
# valid distro :
#       0. Ubuntu
#	1. Debian
#	2. LinuxMint
#	3. Raspbian
#	4. elementary OS 
package_cloud push "dazzltv/public-debpkg/any/any" /app/gst-rtsp-server/build/${PACKAGE_NAME}

# — EOF
