# AWS Deployment Outline

This Terraform module provisions the MVP infrastructure on AWS.

## What it creates

- **Networking**: VPC with public subnets across two AZs, Internet Gateway, route tables.
- **Compute (backend)**: ECS Fargate cluster, task definition, service behind an Application Load Balancer.
- **Container registry**: ECR repository for backend Docker images.
- **Database**: RDS PostgreSQL 14 (`db.t3.micro`).
- **Cache**: ElastiCache Redis 7 (`cache.t3.micro`).
- **Admin frontend**: S3 bucket with static website hosting + CloudFront distribution.

## Usage

1. Install Terraform and configure AWS credentials.
2. Create a `terraform.tfvars` file:

```hcl
db_password       = "change-me-to-a-strong-password"
backend_image     = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/voter-sentiment/backend:latest"
admin_bucket_name = "voter-sentiment-admin-prod-unique"
```

3. Deploy:

```bash
terraform init
terraform plan
terraform apply
```

4. Build and push the backend image:

```bash
cd ../../backend
docker build -t $BACKEND_ECR_URL .
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin $ECR_REGISTRY
docker push $BACKEND_ECR_URL
```

5. Build and upload the admin dashboard:

```bash
cd ../../admin
npm run build
aws s3 sync dist/ s3://$ADMIN_BUCKET_NAME
aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_ID --paths "/*"
```

## Notes

- The RDS instance is not publicly accessible and is placed in the VPC subnets reachable from the ECS backend security group.
- Redis transit encryption is disabled in this outline to keep the MVP simple; enable it for production.
- Use AWS Secrets Manager or SSM Parameter Store for credentials in production instead of plain variables.
