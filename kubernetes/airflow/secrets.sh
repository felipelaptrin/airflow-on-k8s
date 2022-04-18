#!/bin/bash
echo "Creating secrets..."

echo "[SECRETS] Creating webserver key secret"
kubectl create secret generic airflow-webserver-secret-key \
    --from-literal="value=$(python3 -c 'import secrets; print(secrets.token_hex(16))')" \
    -n airflow

echo "[SECRETS] Creating fernet key secret"
kubectl create secret generic airflow-fernet-key \
    --from-literal="value=$(python3 -c 'from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())')" \
    -n airflow

echo "[SECRETS] Creating aws secret"
kubectl create secret generic aws-credentials \
    --from-literal="access-key=${AWS_ACCESS_KEY}" \
    --from-literal="secret-key=${AWS_SECRET_KEY}" \
    -n airflow

echo "[SECRETS] Creating postgres secret"
kubectl create secret generic postgres-database \
    --from-literal="username=${DATABASE_USERNAME}" \
    --from-literal="password=${DATABASE_PASSWORD}" \
    -n airflow