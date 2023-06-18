#!/usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"



PROJECT_ID="roi-mb2023-devops7"
gcloud config set project $PROJECT_ID



REGION="asia-south1"
AR_NAME="${REGION}-docker.pkg.dev"
MY_REPO="my-repo-1"
MY_IMAGE="my-img-1"
ARPY_NAME="${REGION}-python.pkg.dev"
MYPY_REPO="my-py-repo-1"

BUCKET_NAME=${PROJECT_ID}"-build-artifacts"
gcloud storage buckets create gs://${BUCKET_NAME}



gcloud services enable artifactregistry.googleapis.com --async

# docker repo
gcloud artifacts repositories create my-repo-1 \
    --repository-format=docker \
    --location=asia-south1 \
    --description="AMITK Docker repository sample code"

# python repo
gcloud artifacts repositories create ${MYPY_REPO} \
    --repository-format=python \
    --location=${REGION} \
    --description="AMITK Python repository sample code"


gcloud builds submit --region=${REGION} --config=cloudbuild.yaml   \
    --substitutions=_AR_NAME=${AR_NAME},_MY_REPO=${MY_REPO},_MY_IMAGE=${MY_IMAGE},_BUCKET_NAME=${BUCKET_NAME},_ARPY_NAME=${ARPY_NAME},_MYPY_REPO=${MYPY_REPO}




# gcloud builds submit --region=${REGION} --config=cloudbuild.yaml  


gcloud builds submit --region=${REGION} --config=cloudbuild.yaml   \
    --substitutions=_AR_NAME=${AR_NAME},_MY_REPO=${MY_REPO},_MY_IMAGE=${MY_IMAGE}




gcloud auth configure-docker asia-south1-docker.pkg.dev
docker pull \
    asia-south1-docker.pkg.dev/roi-mb2023-devops7/my-repo-1/my-img-1:latest


gcloud artifacts files list --repository=${AR_NAME} --location=${REGION}



