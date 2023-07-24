# Cloud Workstations Debian Desktop

[Cloud Workstations](https://cloud.google.com/workstations/docs/overview) provides managed development environments on Google Cloud. A set of preconfigured images is available to use as-is or they can be customized for specific needs. In this project we opt for another option: building a custom image. 

This image consists of a Debian (Xfce) desktop that can be accessed with [Chrome Remote Desktop](https://support.google.com/chrome/answer/1649523) from any supported device. The gcloud CLI is also included.

In order to use this:
- Clone this repo.
- Use Docker to build the image.
- Push the image to Artifact Registry.
- If you don't already have a Cloud Workstations cluster, create one.
- If you don't already have a Service Account to use for the configuration, create one; see [this](https://cloud.google.com/workstations/docs/customize-development-environment#gceinstance) for more information.
- Create a Workstations configuration referencing the image in Artifact Registry.
- Create Workstations. 

After creating a Workstation, the user must configure it to be accessible via Chrome Remote Desktop by:
- SSH into Workstation.
- In Chrome, navigate to [Chrome Remote Desktop](https://remotedesktop.google.com/headless); click on 'Begin', then 'Next', then 'Authorize'.
- Copy the provided Debian Linux command and execute it in the SSH terminal and select a 6-digit code when prompted.
- Run the following command on the SSH terminal: `/usr/sbin/service chrome-remote-desktop restart`
- Close the SSH terminal.
- The Workstation should now be accessible via the Remote Access tab on the Chrome Remote Desktop page.

# Acknowledgement and Resources
- This [repo](https://github.com/mchmarny/custom-cloud-workstation-image) was extremely helpful; I borrowed heavily from it and wish to acknowledge the author. It includes an update pipeline for the image which may also be of interest.
- [Set up Chrome Remote Desktop for Linux on Compute Engine](https://cloud.google.com/architecture/chrome-desktop-remote-on-compute-engine#xfce)