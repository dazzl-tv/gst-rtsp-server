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

echo "------------------------------------------"
echo " PUSINGING DEBIAN PACKAGE TO PACKAGECLOUD "
echo "------------------------------------------"

gem install package_cloud

# package_cloud push <username>/<reponame>/any/any <deb file>
package_cloud push dazzltv/public-debpkg /app/gst-rtsp-server/build/gst-1.0-rtspclientsink-1.16.2.deb

# — EOF
