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

GST_SOURCE="${PWD}"
PACKAGE_NAME="gst-1.0-rtspclientsink-${1}.deb"

echo "------------------------------------------"
echo " PUSINGING DEBIAN PACKAGE TO PACKAGECLOUD "
echo "------------------------------------------"

gem install package_cloud

# package_cloud push <username>/<reponame>/any/any <deb file>
# user/repo[/distro/version
package_cloud push dazzltv/public-debpkg/Ubuntu /app/gst-rtsp-server/build/${PACKAGE_NAME}

# — EOF
