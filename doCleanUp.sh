#!/usr/bin/bash


NL="\n"
YELLOW="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"



PROJECT_ID="roi-mb2023-devops7"
gcloud config set project $PROJECT_ID



echo -e "${GREEN} ${NL} Deleting Asset Inventory ${NL}  ${NC}" 
FEED_NAME="assets"

if $(gcloud asset feeds  describe  ${FEED_NAME}  >/dev/null 2>&1)
then
	gcloud asset feeds delete ${FEED_NAME} --project ${PROJECT_ID} --quiet
else
	echo -e "${YELLOW}missing Asset feed  ${FEED_NAME}  ${NC}"
fi


    


echo -e "${GREEN} ${NL} Deleting Cloud Functions ${NL}  ${NC}" 
FUNCTION_NAME="pubsubtobq"
REGION="us-central1"

if $(gcloud functions describe $FUNCTION_NAME  >/dev/null 2>&1)
then
	gcloud functions delete ${FUNCTION_NAME}  --region ${REGION}  --project ${PROJECT_ID} --quiet
else
	echo -e  "${YELLOW}missing Cloud Functions ${FUNCTION_NAME}  ${NC} "
fi






echo -e "${GREEN} ${NL} Deleting Source Repo ${NL}  ${NC}" 
REPO_NAME="mb2023-st07"
REPO_URL="https://source.developers.google.com/p/${PROJECT_ID}/r/${REPO_NAME} "

if $(gcloud source repos describe $REPO_NAME  >/dev/null 2>&1)
then
	gcloud source repos delete $REPO_NAME  --quiet 
else
    echo -e "${YELLOW}missing Source Repo  $REPO_NAME  ${NC}"
fi







echo -e "${GREEN} ${NL} Deleting Pub Sub ${NL}  ${NC}" 
TOPIC_NAME="activities"
SUBSCR_NAME="activites-catchall"

if $(gcloud pubsub subscriptions describe  ${SUBSCR_NAME}  >/dev/null 2>&1)
then
	gcloud pubsub subscriptions delete  ${SUBSCR_NAME} --quiet 
else
	echo -e "${YELLOW}missing Subscription  ${SUBSCR_NAME}  ${NC}"
fi

if $(gcloud pubsub topics describe  ${TOPIC_NAME}  >/dev/null 2>&1)
then
	gcloud pubsub topics delete  ${TOPIC_NAME} --quiet 
else
	echo -e "${YELLOW}missing Topic ${TOPIC_NAME}  ${NC}"
fi





echo -e "${GREEN} ${NL} Deleting BQ ${NL}  ${NC}" 
DATASET_NAME="activities"
TABLE_NAME="resources"
TABLE_NAME2="exports"


if $(bq show ${DATASET_NAME}.${TABLE_NAME} >/dev/null 2>&1)
then
	bq rm   --force=true -t ${PROJECT_ID}:${DATASET_NAME}.${TABLE_NAME2} 
else
	echo  -e "${YELLOW}missing BQ Table ${DATASET_NAME}.${TABLE_NAME2}  ${NC}"
fi

if $(bq show ${DATASET_NAME}.${TABLE_NAME} >/dev/null 2>&1)
then
	bq rm   --force=true -t ${PROJECT_ID}:${DATASET_NAME}.${TABLE_NAME}  
else
	echo -e "${YELLOW}missing BQ Table  ${DATASET_NAME}.${TABLE_NAME}  ${NC}"
fi

if $(bq ls -d ${DATASET_NAME} >/dev/null 2>&1)
then
	bq rm  --force=true -d ${PROJECT_ID}:${DATASET_NAME}  
else
	echo -e "${YELLOW}missing BQ Dataset  ${DATASET_NAME} ${NC}"
fi









echo -e "${GREEN} ${NL} Deleting Bucket ${NL}  ${NC}" 
BUCKET_NAME="gs://"${PROJECT_ID}"-bucket"
if $(gcloud storage buckets describe  ${BUCKET_NAME}  >/dev/null 2>&1)
then
	gcloud storage buckets delete  ${BUCKET_NAME}  --quiet
else
	echo -e "${YELLOW}missing bucket ${BUCKET_NAME} ${NC}"	
fi



echo -e "project items clean up completed"

