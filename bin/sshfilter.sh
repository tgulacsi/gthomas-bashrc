#!/bin/bash

# UPPERCASE space-separated country codes to ACCEPT
ALLOW_COUNTRIES="HU AT DE GB FR"

if [ $# -ne 1 ]; then
	echo "Usage:  $(basename $0) <ip>" 1>&2
	exit 0 # return true in case of config issue
fi

COUNTRY=$(/usr/bin/geoiplookup $1 | awk -F ": " '{ print $2 }' | cut -d, -f1 | head -n 1)

if [[ $COUNTRY == "IP Address not found" || $ALLOW_COUNTRIES =~ $COUNTRY ]]; then
	exit 0
fi

logger "DENY sshd connection from $1 ($COUNTRY)"
exit 1
