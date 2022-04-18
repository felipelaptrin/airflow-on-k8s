
## Deployed Services 

### Airflow
- Use of KubernetesExecutor
- Logs written on AWS S3
- Automatically created an Airflow connection with AWS credetials (to support writing logs)
- GitSync activated
- Created Fernet key and Webserver key
- Use of PostgreSQL database managed by AWS RDS as the database (created via Terraform)