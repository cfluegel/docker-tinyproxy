#!/bin/bash 
# 

PORT=${LISTENPORT:-8888}

TEMPFILE="$(mktemp)"

CONFIGFILE="/etc/tinyproxy/tinyproxy.conf"

# Replace the port if supplied 
sed -i "s/%LISTENPORT%/$PORT/g" ${CONFIGFILE}

# Add new Allowlines for each IP Range 
if [ -n "$ALLOWEDRANGES" ]; then 
	echo $ALLOWEDRANGES | tr ',' '\n' | while read range; do 
        echo "Allow $range" >> ${TEMPFILE}
	done 
fi 

# Add the contents of the temp file 
sed -i "/# dynamicRanges/r ${TEMPFILE}" ${CONFIGFILE}

# /usr/bin/tinyproxy -d 
cat /etc/tinyproxy/tinyproxy.conf
