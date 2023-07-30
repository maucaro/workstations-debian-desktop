# Cloud Workstations Debian Desktop

[Cloud Workstations](https://cloud.google.com/workstations/docs/overview) provides managed development environments on Google Cloud. A set of preconfigured images is available to use as-is or they can be customized for specific needs. In this project we opt for another option: building a custom image. 

This image consists of a Debian (Xfce) desktop that can be accessed with and RDP client via [Xrdp](https://www.xrdp.org/) from any supported device. The gcloud CLI is also included in the image.

In order to use this:
- Clone this repo.
- You may want to modify or delete the Firefox policy file (assets/etc/firefox/policies/policies.json). 
- Use Docker to build the image.
- Push the image to Artifact Registry.
- If you don't already have a Cloud Workstations cluster, create one.
- If you don't already have a Service Account to use for the configuration, create one; see [this](https://cloud.google.com/workstations/docs/customize-development-environment#gceinstance) for more information.
- Create a Workstations configuration referencing the image in Artifact Registry.
- Create Workstations. 

After creating a Workstation, in order to connect to it:
- Create an SSH tunnel to the RDP port (3389) with the following command:

`
gcloud beta workstations start-tcp-tunnel --project=$PROJECT_ID --cluster=$CLUSTER --config=$CONFIG --region=$REGION $WORKSTATION 3389
`
- Use an RDP client to connect to localhost:PORT (where PORT is the randomly chosen port from the previous command), 'user' as the user name and a blank password. 

# Acknowledgement
- This [repo](https://github.com/mchmarny/custom-cloud-workstation-image) was extremely helpful; I borrowed heavily from it and wish to acknowledge the author. It includes an update pipeline for the image which may also be of interest.
