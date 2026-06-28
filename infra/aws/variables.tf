variable "aws_region" {
  description = "AWS region for the MVP deployment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project prefix for all resources"
  type        = string
  default     = "voter-sentiment"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "prod"
}

variable "db_username" {
  description = "PostgreSQL master username"
  type        = string
  default     = "voter"
}

variable "db_password" {
  description = "PostgreSQL master password"
  type        = string
  sensitive   = true
}

variable "backend_image" {
  description = "Backend container image URI (e.g. ECR repo URL)"
  type        = string
}

variable "admin_bucket_name" {
  description = "Globally unique S3 bucket name for the admin React app"
  type        = string
}
