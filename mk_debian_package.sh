#!/bin/bash 
# 
# Bash script used to package the gstreamer rtspclientsink module as debian one
# 
# ./mk_debian_package.sh "1.16.2"
#
#set -x # mode debug

GST_VERSION="$1" 
GST_SOURCE="${PWD}"
PACKAGE_DELIVERY="${PWD}/gst-${GST_VERSION}-rtspclientsink"
GST_TARGET_PATH="usr/lib/x86_64-linux-gnu/gstreamer-1.0"
GST_LIBRARY=${GST_SOURCE}/build/gst/rtsp-sink/libgstrtspclientsink.so
PACKAGE_DELIVERY_CONTENT="${PACKAGE_DELIVERY}/${GST_TARGET_PATH}"
PACKAGE_DELIVERY_DEBIAN="${PACKAGE_DELIVERY}/DEBIAN"

echo "--------------------------------------------------"
echo " MAKING DEBIAN PACKAGE FOR THE GST/RTSPCLIENTSINK "
echo "--------------------------------------------------"

# --- Make directories
if [ -d "${PACKAGE_DELIVERY}" ]; then
	echo "--> Removing old delivery directory!"
	rm -fR ${PACKAGE_DELIVERY}
fi
mkdir -p ${PACKAGE_DELIVERY_CONTENT}
mkdir -p ${PACKAGE_DELIVERY_DEBIAN}

# --- Adding gst library

echo "GST_LIBRARY='${GST_LIBRARY}'"
echo "PACKAGE_DELIVERY_CONTENT='${PACKAGE_DELIVERY_CONTENT}'"
cp  "${GST_LIBRARY}"  "${PACKAGE_DELIVERY_CONTENT}/"

# --- Creation d’un répertoire contenant le fichiers de description ainsi que les hooks 
cat <<- EOF > ${PACKAGE_DELIVERY_DEBIAN}/control
	Package: rtspclientsink
	Version: ${GST_VERSION}
	Section: base
	Priority: optional
	Architecture: all
	Depends: debhelper (>=9)
	Maintainer: Thierry GAYET <thierry.gayet@dazzl.tv>
	Description: gstreamer module patched for evostream
	Homepage: https://www.aviwest.com
EOF

# — Creation des heredocs pour les hooks (template vides pour un usage ultérieur 
cat <<- EOF > ${PACKAGE_DELIVERY_DEBIAN}/preinst
echo " -> preinst callback "
EOF

cat <<- EOF > ${PACKAGE_DELIVERY_DEBIAN}/postinst
echo " -> postinst callback"
EOF

cat <<- EOF > ${PACKAGE_DELIVERY_DEBIAN}/prerm
echo " -> prerm callback"
EOF

cat <<- EOF > ${PACKAGE_DELIVERY_DEBIAN}/postrm
echo " -> postrm callback"
EOF
chmod 755 ${PACKAGE_DELIVERY_DEBIAN}/post* 
chmod 755 ${PACKAGE_DELIVERY_DEBIAN}/pre* 

# --- Display several metadata 
cat ${PACKAGE_DELIVERY}/DEBIAN/control
tree ${PACKAGE_DELIVERY}

# --- Lance la génération du package debian 
dpkg-deb --verbose --build ${PACKAGE_DELIVERY} ${GST_SOURCE}/build/gst-1.0-rtspclientsink-${GST_VERSION}.deb 
if [ -e "${GST_SOURCE}/build/gst-1.0-rtspclientsink-${GST_VERSION}.deb" ]; then 
	#ls -al     ${GST_SOURCE}/build/gst-1.0-rtspclientsink-${GST_VERSION}.deb 
	#file        ${GST_SOURCE}/build/gst-1.0-rtspclientsink-${GST_VERSION}.deb
	dpkg-deb -I ${GST_SOURCE}/build/gst-1.0-rtspclientsink-${GST_VERSION}.deb
	
	# — Supression du workspace temporaire 
	if [ -d "${PACKAGE_DELIVERY}" ]; then 
		rm -fR ${PACKAGE_DELIVERY} 
	fi
else
	echo "[ERROR] Cannot found the debian package!"
fi  

# — EOF
