#!/bin/bash
if [ -z "$1" ]
  then
    echo "Usage: build.sh TAG"
    echo "Where TAG is the tag for the image."
    exit 1
fi
PROJECT_ID=$(gcloud config get-value project)
TAG=$1
REGION=us-central1
repo=$REGION-docker.pkg.dev/$PROJECT_ID/workstations-repo
docker push $repo/debian-desktop:$TAG  