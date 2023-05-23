#!/usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"


echo -e "starting GCP setup" 


PROJECT_ID="roi-mb2023-devops7"
gcloud config set project $PROJECT_ID



echo -e "${GREEN} ${NL} Working with APIs ${NL}  ${NC}" 

declare -a default_service_list
declare -a my_service_list

default_service_list=(
      "compute.googleapis.com"
      "bigquery.googleapis.com"
      "bigquerymigration.googleapis.com"
      "bigquerystorage.googleapis.com"
      "cloudapis.googleapis.com"
      "clouddebugger.googleapis.com"
      "cloudtrace.googleapis.com"
      "logging.googleapis.com"
      "monitoring.googleapis.com"
      "servicemanagement.googleapis.com"
      "serviceusage.googleapis.com"
      "sql-component.googleapis.com"
      "storage.googleapis.com"
      "storage-api.googleapis.com"
      "storage-component.googleapis.com"
	)

for api in "${default_service_list[@]}"
do 
	gcloud services enable ${api} --async
done 

my_service_list=(
      "cloudasset.googleapis.com"
      "cloudbuild.googleapis.com"
      "cloudfunctions.googleapis.com"
      "containerregistry.googleapis.com"
      "cloudresourcemanager.googleapis.com"
      "iam.googleapis.com"
      "pubsub.googleapis.com"
      "sourcerepo.googleapis.com"
    )

for api in "${my_service_list[@]}"
do 
	gcloud services enable ${api} --async
done 

