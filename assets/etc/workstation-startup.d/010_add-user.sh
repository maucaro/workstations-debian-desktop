#!/bin/bash

#
# Startup script to add default and xrdp users to workstation container and assign group membership.
#

echo "Starting 010_add-user.sh"

set -e

groups=sudo 
useradd -m user -G $groups --shell /bin/bash > /dev/null
passwd -d user >/dev/null
echo "%sudo ALL=NOPASSWD: ALL" >> /etc/sudoers
adduser xrdp ssl-cert  

echo "Exiting 010_add-user.sh"