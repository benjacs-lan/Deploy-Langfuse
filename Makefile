.PHONY: init plan apply destroy status logs

# Inicializa Terraform
init:
	tflocal -chdir=terraform init

# Muestra qué recursos se van a crear/modificar
plan:
	tflocal -chdir=terraform plan

# Aplica la infraestructura sin preguntar "yes"
apply:
	tflocal -chdir=terraform apply -auto-approve

# Destruye toda la infraestructura sin preguntar
destroy:
	tflocal -chdir=terraform destroy -auto-approve

# Muestra el estado de los recursos de AWS (S3 e IAM)
status:
	@echo "=== S3 Buckets ==="
	awslocal s3 ls
	@echo "\n=== IAM Roles ==="
	awslocal iam list-roles --query "Roles[*].{RoleName:RoleName}" --output table

# Muestra los objetos dentro del bucket de Langfuse
bucket-files:
	awslocal s3 ls s3://langsfuse-bucket --recursive

# Muestra los logs de los contenedores de Docker (Langfuse, BD y LocalStack)
logs:
	docker compose logs -f