FROM debian:11

RUN apt update
RUN apt install --assume-yes curl

# Install an X Windows System desktop environment (Xfce)
RUN DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes xfce4 desktop-base dbus-x11 xscreensaver xorg  x11-xserver-utils
RUN apt install --assume-yes task-xfce-desktop
RUN apt install --assume-yes xrdp 

# gcloud CLI installation reference:
# https://cloud.google.com/sdk/docs/install#deb
RUN apt-get --assume-yes install apt-transport-https ca-certificates gnupg sudo
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y
      
# Install OpenSSH
RUN apt-get -y install openssh-client openssh-server && \
    rm -rf /etc/ssh/ssh_host_*  # remove auto-created host keys

# Copy files from the assets directory
COPY ./assets/. /

ENTRYPOINT [ "/google/scripts/entrypoint.sh" ]