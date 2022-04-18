make airflow:
	@echo "Remember to set AWS_ACCESS_KEY, AWS_SECRET_KEY, DATABASE_USER, DATABASE_PASSWORD."
	@echo "Make sure to modify the externalDatabase value in the /kubernetes/airflow/values.yaml accordingly"
	@echo "Creating namespace for airflow deployment"
	@kubectl apply -f ./kubernetes/airflow/namespace.yaml
	@echo "Setting up Airflow into the K8S cluster"
	@bash ./scripts/airflow_deploy.sh
