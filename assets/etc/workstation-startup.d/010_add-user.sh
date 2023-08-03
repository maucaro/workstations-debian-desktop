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

# Set proxy environment variables
file=/home/user/.bashrc
[ ! -z "${http_proxy}" ] && echo "http_proxy=$http_proxy" >> $file
[ ! -z "${https_proxy}" ] && echo "https_proxy=$https_proxy" >> $file
[ ! -z "${no_proxy}" ] && echo "no_proxy=$no_proxy" >> $file

echo "Exiting 010_add-user.sh"