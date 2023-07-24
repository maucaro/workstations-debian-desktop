#!/bin/bash

#
# Startup script to start Chrome Remote Desktop.
#

echo "Starting 200_crd.sh"

set -e

file="/home/user/.chrome-remote-desktop"

usermod -aG chrome-remote-desktop user
/usr/sbin/service chrome-remote-desktop start
/usr/sbin/service pulseaudio-enable-autospawn start

touch $file
chown user:user $file
echo '/usr/bin/pulseaudio --start' > $file

echo "Exiting 200_crd.sh"