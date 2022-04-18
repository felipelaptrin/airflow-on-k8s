#!/bin/bash
################################################################################
# Script:       Airflow Deploy
# Description:  Deploy Airflow into K8S cluster using Community Helm Chart
# Notes:        There are four environment variable that need to be set 
#               in order to be deploy Airflow. They are:
#               1 - AWS_ACCESS_KEY:    IAM User Access Key used to write logs on S3
#               2 - AWS_SECRET_KEY:    IAM User Secret Key used to write logs on S3
#               3 - DATABASE_USER:     User of the external database
#               4 - DATABASE_PASSWORD: Password of the user of the external database
#               Also, make sure to edit the `externalDatabase` according to your database info
################################################################################
for var in "$AWS_ACCESS_KEY" "$AWS_SECRET_KEY" "$DATABASE_USER" "$DATABASE_PASSWORD"; do
    if [[ -z "$var" ]] ; then
        echo "ERROR: AWS_ACCESS_KEY, AWS_SECRET_KEY, DATABASE_USER and DATABASE_PASSWORD must be set accordingly."
        exit 1
    fi
done

source ./kubernetes/airflow/secrets.sh

helm repo add airflow-helm https://airflow-helm.github.io/charts

helm upgrade --install airflow airflow-helm/airflow \
    --version 8.6.0 \
    -n airflow \
    -f ./kubernetes/airflow/values.yaml
