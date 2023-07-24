FROM debian:11

# Chrome Remote Deskto installation reference: 
# https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#install_the_remote_desktop_chrome_app
# Pre-reqs
RUN apt update
RUN apt install --assume-yes curl

# Install Chrome Remote Desktop on the VM instance
RUN curl -L -o chrome-remote-desktop_current_amd64.deb https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get install --assume-yes ./chrome-remote-desktop_current_amd64.deb

# Install an X Windows System desktop environment (Xfce)
RUN DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes xfce4 desktop-base dbus-x11 xscreensaver
RUN bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'
RUN apt install --assume-yes task-xfce-desktop

# gcloud CLI installation reference:
# https://cloud.google.com/sdk/docs/install#deb
RUN apt-get --assume-yes install apt-transport-https ca-certificates gnupg sudo
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-cli -y
      
# Install OpenSSH
RUN apt-get -y install openssh-client openssh-server && \
    rm -rf /etc/ssh/ssh_host_*  # remove auto-created host keys

# Copy files from the assets directory
COPY ./assets/. /
RUN chmod +x /usr/bin/workstation-startup
RUN chmod +x /google/scripts/entrypoint.sh
RUN chmod -R +x /etc/workstation-startup.d

ENTRYPOINT [ "/google/scripts/entrypoint.sh" ]