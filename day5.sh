#!/usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"


echo -e "starting GCP setup" 


gcloud logging sink create custom_sink1 \
    logging.googleapis.com/projects/playground-s-11-4f18cab1/locations/europe-west1/buckets/custom_log_bucket1
    --log-filter="NOT LOG_ID("cloudaudit.googleapis.com/activity") "
    --organization = 