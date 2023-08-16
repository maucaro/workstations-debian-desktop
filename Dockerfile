FROM debian:11

RUN apt update && apt upgrade --assume-yes
RUN apt install --assume-yes curl

# Install an X Windows System desktop environment (Xfce)
RUN DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes xfce4 desktop-base dbus-x11 xscreensaver xorg  x11-xserver-utils
RUN apt install --assume-yes task-xfce-desktop
RUN apt install --assume-yes xrdp 

# gcloud CLI installation 
# reference: https://cloud.google.com/sdk/docs/install#deb
RUN apt-get --assume-yes install apt-transport-https ca-certificates gnupg sudo
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | \
    tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
    apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y
      
# Install OpenSSH
RUN apt-get -y install openssh-client openssh-server && \
    rm -rf /etc/ssh/ssh_host_*  # remove auto-created host keys

# Sound redirection support for Xrdp 
# reference: https://c-nergy.be/blog/?p=13655
RUN echo 'deb-src http://deb.debian.org/debian bullseye main' >> /etc/apt/sources.list && apt update
RUN apt-get install git libpulse-dev autoconf m4 intltool build-essential dpkg-dev -y
RUN apt build-dep pulseaudio -y
RUN cd /tmp && apt source pulseaudio
RUN pulsever=$(pulseaudio --version | awk '{print $2}') && \
    cd /tmp/pulseaudio-$pulsever && \
    ./configure && \
    git clone https://github.com/neutrinolabs/pulseaudio-module-xrdp.git
RUN pulsever=$(pulseaudio --version | awk '{print $2}') && \
    cd /tmp/pulseaudio-$pulsever/pulseaudio-module-xrdp && \
    ./bootstrap && \
    ./configure PULSE_DIR="/tmp/pulseaudio-$pulsever" && \
    make
RUN pulsever=$(pulseaudio --version | awk '{print $2}') && \
    cd /tmp/pulseaudio-$pulsever/pulseaudio-module-xrdp/src/.libs && \
    install -t "/var/lib/xrdp-pulseaudio-installer" -D -m 644 *.so

# Install Chrome
RUN curl -L -o google-chrome-stable_current_amd64.deb \
https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install --assume-yes ./google-chrome-stable_current_amd64.deb

# Copy files from the assets directory
COPY ./assets/. /

ENTRYPOINT [ "/google/scripts/entrypoint.sh" ]