
🚀 Strapi + PostgreSQL on AWS ECS Fargate

Deploy Strapi CMS with PostgreSQL on AWS ECS Fargate using Terraform and GitHub Actions. Fully automated CI/CD, scalable, and production-ready.



🔹 Features

Containerized Strapi CMS

PostgreSQL 15 database

AWS ECS Fargate deployment (serverless containers)

Application Load Balancer (ALB) for external access

Infrastructure as Code with Terraform

CI/CD pipeline with GitHub Actions

CloudWatch logging for monitoring



📦 Prerequisites

AWS Account with permissions for ECS, ECR, S3, IAM

Terraform >= 1.6.0

GitHub repository with the following Secrets:

Secret Name	Purpose

AWS_ACCESS_KEY_ID	AWS IAM access key

AWS_SECRET_ACCESS_KEY	AWS IAM secret key

AWS_REGION	AWS Region (e.g., ap-south-1)

DB_PASSWORD	PostgreSQL password

ECR_REPOSITORY	Strapi Docker image URI in ECR



📁 Repository Structure

terraform/

├─ provider.tf          # AWS provider config

├─ vpc.tf               # VPC, subnets, IGW, route tables

├─ sg.tf                # Security group

├─ ecs.tf               # ECS cluster

├─ ecs-td.tf            # ECS task definition (Strapi + Postgres)

├─ ecs-service.tf       # ECS Fargate service

├─ alb.tf               # Application Load Balancer

├─ tg.tf                # Target Group

├─ backend.tf           # S3 backend for Terraform state

├─ variables.tf         # Variables

├─ outputs.tf           # Outputs (ALB DNS)

├─ iam.tf               # IAM roles/data

└─ .github/workflows/

   └─ deploy.yml        # GitHub Actions CI/CD workflow

   

⚡ Terraform Deployment

1. Initialize

cd terraform

terraform init

3. Plan
   
terraform plan \

  -var "db_password=<POSTGRES_PASSWORD>" \
  
  -var "image_uri=<ECR_IMAGE_URI>"
  

5. Apply
   
terraform apply -auto-approve \

  -var "db_password=<POSTGRES_PASSWORD>" \
  
  -var "image_uri=<ECR_IMAGE_URI>"
  


✅ Creates VPC, Subnets, Security Groups, ECS Cluster, ALB, Target Groups, Fargate Service, and CloudWatch log groups.

4. Destroy
   
terraform destroy -auto-approve \

  -var "db_password=<POSTGRES_PASSWORD>" \
  
  -var "image_uri=<ECR_IMAGE_URI>"



🛠 GitHub Actions CI/CD

Workflow: .github/workflows/deploy.yml

Steps:

Checkout repository

Configure AWS credentials

Setup Terraform

Run terraform init and terraform apply

Secrets required: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_REGION, DB_PASSWORD, ECR_REPOSITORY

🌐 Access Strapi

Get ALB DNS from Terraform output:

terraform output lb_dns_name


Open in browser:

http://<ALB_DNS>:1337/admin


Database: strapidb

📌 Notes

Ensure Strapi env variables match Postgres container credentials.

CloudWatch logs:

/ecs/strapi → Strapi logs

/ecs/postgres → PostgreSQL logs

For initial data, use /docker-entrypoint-initdb.d/ scripts in Postgres container.

🎯 Next Steps

Add SSL/TLS to ALB

Enable auto-scaling for ECS service

Use RDS for managed Postgres in production

✅ Your Strapi CMS is now production-ready on AWS Fargate with full automation!
