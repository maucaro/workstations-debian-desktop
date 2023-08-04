#!/bin/bash

#
# Startup script to modify the user's environment.
#

echo "Starting 015_custom-user.sh"

set -e

# Set proxy environment variables per values passed in to the container (--env) if present
file=/home/user/.bashrc
[ ! -z "${http_proxy}" ] && echo "http_proxy=$http_proxy" >> $file
[ ! -z "${https_proxy}" ] && echo "https_proxy=$https_proxy" >> $file
[ ! -z "${no_proxy}" ] && echo "no_proxy=$no_proxy" >> $file

echo "Exiting 015_custom-user.sh"