#!/usr/bin/bash


NL="\n"
RED="\e[1;31m"
GREEN="\e[1;32m"
YELLOW="\e[1;33m"
BLUE="\e[1;34m"
NC="\e[1;0m"

PATH=$(dirname $0 )
LOGFILE=${PATH}"/day0_setup.log"
echo " " > ${LOGFILE}



PROJECT_ID="roi-mb2023-devops7"
gcloud config set project $PROJECT_ID  

gcloud services enable "sourcerepo.googleapis.com"   

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
    if [[  -d ./PLUTO ]]; then
        echo -e "PLUTO exists"
    else
        git clone https://github.com/ROIGCP/PLUTO  
    fi 
    cd PLUTO   

    git remote add google  ${REPO_URL}   
    git push --all google   

fi


echo -e "${GREEN} ${NL} Working with Terraform for remaining objects ${NL}  ${NC}" 
cd ~/PLUTO/terraform

terraform init   

terraform plan   

terraform apply   



# echo -e "${GREEN} ${NL} Terra apply done ${NL}  ${NC}" 

