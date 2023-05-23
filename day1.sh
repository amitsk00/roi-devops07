#!/usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"



PROJECT_ID="roi-mb2023-devops7"
gcloud config set project $PROJECT_ID



echo -e "${GREEN} ${NL} Working with Bucket ${NL}  ${NC}" 

BUCKET_NAME="gs://"${PROJECT_ID}"-bucket"

if $(gcloud storage buckets describe  ${BUCKET_NAME}  >/dev/null 2>&1)
then
	echo -e "bucket is present"
else
	echo  -e "${RED}missing bucket ${NC}"
	gsutil mb ${BUCKET_NAME}
fi





echo -e "${GREEN} ${NL} Working with BQ ${NL}  ${NC}" 

DATASET_NAME="activities"
TABLE_NAME="resources"

if $(bq ls -d ${DATASET_NAME} >/dev/null 2>&1)
then
	echo -e "BQ Dataset is present"
else
	echo -e "${RED}missing BQ Dataset ${NC}"
	bq mk -d ${DATASET_NAME}
fi

if $(bq show ${DATASET_NAME}.${TABLE_NAME} >/dev/null 2>&1)
then
	echo -e "BQ Table is present"
else
	echo -e "${RED}missing BQ Table ${NC}"
	bq mk --schema messages:STRING -t ${DATASET_NAME}.${TABLE_NAME}
fi




echo -e "${GREEN} ${NL} Working with Pub Sub ${NL}  ${NC}" 

TOPIC_NAME="activities"
SUBSCR_NAME="activites-catchall"

if $(gcloud pubsub topics describe  ${TOPIC_NAME}  >/dev/null 2>&1)
then
	echo  -e "Topic is present"
else
	echo  -e "${RED}missing Topic ${NC}"
	gcloud pubsub topics create ${TOPIC_NAME}
fi


if $(gcloud pubsub subscriptions describe  ${SUBSCR_NAME}  >/dev/null 2>&1)
then
	echo  -e "Subscription is present"
else
	echo -e  "${RED}missing Subscription ${NC}"
	gcloud pubsub subscriptions create  ${SUBSCR_NAME} --topic projects/${PROJECT_ID}/topics/${TOPIC_NAME}
fi

TOPIC_URL=$(gcloud pubsub topics describe ${TOPIC_NAME} --format="value(name)")





echo -e "${GREEN} ${NL} Working with Source Repo ${NL}  ${NC}" 

REPO_NAME="mb2023-st07"
REPO_URL="https://source.developers.google.com/p/${PROJECT_ID}/r/${REPO_NAME} "

if $(gcloud source repos describe $REPO_NAME  >/dev/null 2>&1)
then
	echo  -e "Source Repo is present"
else
	echo -e "${RED}missing Source Repo ${NC}"
	gcloud  source repos create  ${REPO_NAME} 

      cd ~
      if [[ -d ./PLUTO ]];
      then  
            echo -e "${GREEN}Repo directory is already present${NC}"
      else
            git clone https://github.com/ROIGCP/PLUTO 
            cd PLUTO
      fi

      git remote add google  ${REPO_URL}
      git push --all google

fi




echo -e "${GREEN} ${NL} Working with Cloud Functions ${NL}  ${NC}" 

FUNCTION_NAME="pubsubtobq"
REGION="us-central1"
RUNTIME="python39"
# SRC_LOC=$REPO_URL
SRC_LOC="https://source.developers.google.com/projects/${PROJECT_ID}/repos/${REPO_NAME}/moveable-aliases/master/paths/cloudfunction"
ENTRY_POINT="pubsub_to_bigquery"


if $(gcloud functions describe $FUNCTION_NAME  >/dev/null 2>&1)
then
	echo -e  "Cloud Functions is present"
else
	echo -e  "${RED}missing Cloud Functions ${NC} "

      gcloud functions deploy ${FUNCTION_NAME} \
            --region=${REGION} \
            --runtime=${RUNTIME} \
            --source=${SRC_LOC} \
            --entry-point=${ENTRY_POINT} \
            --trigger-topic=${TOPIC_NAME}

fi





# echo -e "${GREEN} ${NL} Working with Asset Inventory ${NL}  ${NC}" 

# TABLE_ASSINV_NAME="export"
# FEED_NAME="assets"
# gcloud asset export --project ${PROJECT_ID} --bigquery-table ${TABLE_ASSINV_NAME} --bigquery-dataset ${DATASET_NAME}


# if $(gcloud asset feeds  describe  ${FEED_NAME}  >/dev/null 2>&1)
# then
# 	echo -e "Asset feed is present"
# else
# 	echo -e "${RED}missing Asset feed ${NC}"
# 	gcloud asset feeds create ${FEED_NAME} --project ${PROJECT_ID}  \
#             --content-type=resource --asset-types="compute.googleapis.com.*"  \
#             --pubsub-topic ${TOPIC_URL}
# fi



