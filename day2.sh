#!/usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"



PROJECT_ID="roi-mb2023-devops7"
gcloud config set project $PROJECT_ID

PROJECT_NUMBER=$(gcloud projects  describe $PROJECT_ID --format="value(projectNumber)")
BUILD_SA=service-${PROJECT_NUMBER}@gcp-sa-cloudbuild.iam.gserviceaccount.com

ROLE1="roles/cloudbuild.serviceAgent"
ROLE2="roles/secretmanager.admin"

# gcloud projects get-iam-policy  ${PROJECT_ID}

gcloud projects add-iam-policy-binding   ${PROJECT_ID} \
   --member="serviceAccount:${BUILD_SA}" \
   --role="${ROLE1}" 

gcloud projects add-iam-policy-binding   ${PROJECT_ID} \
   --member="serviceAccount:${BUILD_SA}" \
   --role="${ROLE2}" 


API1="pubsub.googleapis.com"
gcloud services enable ${API1}


BUILD_TOPIC="cloud-builds"
TMP_SA=$(gcloud pubsub topics describe  --project ${PROJECT_ID} ${BUILD_TOPIC} 2>/dev/null )
if [[ ! ${TMP_SA} ]]; then
    echo -e "pub sub topic not defined"
    # gcloud pubsub topics create ${BUILD_TOPIC}
else
    echo -e "pub sub topic defined"

fi




