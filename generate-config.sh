#!/bin/sh

# Substitute variables in cloud-config template files and save to disk as ".template-secret"
#
# Usage:
#  $ ./inject-variables.sh templatefile 
# * templatefile: the cloud-config template file to use

CONFIGFILE="./.cloud-config-vars"

if [ -z "$1" ] || [ ! -f "$1" ]; then
    echo "Error: template file not readable or missing"
    exit 1
fi

OUTFILE="${1}-secret"

if [ ! -f "$CONFIGFILE" ]; then
    echo "Error: .cloud-config-vars not found"
    exit 2
fi

. $CONFIGFILE

sed " \
s|##PASSWDHASH##|$PASSWDHASH|; \
s/##STORAGEBOXCONF##/$STORAGEBOXCONF/g; \
s/##STORAGEBOXUSER##/$STORAGEBOXUSER/; \
s/##HOMEVOLUMEID##/$HOMEVOLUMEID/; \
" $1 > $OUTFILE
