#!/bin/bash

#
# Startup script to start Chrome Remote Desktop.
#

echo "Starting 200_start-remote.sh"

set -e

/usr/sbin/service pulseaudio-enable-autospawn start
/usr/sbin/service xrdp start

echo "Exiting 200_start-remote.sh"