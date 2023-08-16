#!/bin/bash

#
# Startup script to modify the user's environment.
#

echo "Starting 015_custom-user.sh"

set -e

# Set proxy environment variables per values passed in to the container (--env) if present
file=/etc/profile.d/proxy.sh
[ ! -z "${http_proxy}" ] && echo "export http_proxy=$http_proxy" >> $file
[ ! -z "${https_proxy}" ] && echo "export https_proxy=$https_proxy" >> $file
[ ! -z "${no_proxy}" ] && echo "export no_proxy=$no_proxy" >> $file

chmod +x $file

echo "Exiting 015_custom-user.sh"