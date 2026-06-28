output "backend_ecr_repository_url" {
  description = "URL to push backend Docker images"
  value       = aws_ecr_repository.backend.repository_url
}

output "backend_alb_dns" {
  description = "Public DNS of the backend load balancer"
  value       = aws_alb.main.dns_name
}

output "postgres_endpoint" {
  description = "RDS PostgreSQL endpoint"
  value       = aws_db_instance.postgres.address
}

output "redis_endpoint" {
  description = "ElastiCache Redis primary endpoint"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

output "admin_cloudfront_domain" {
  description = "CloudFront domain for the admin dashboard"
  value       = aws_cloudfront_distribution.admin.domain_name
}

output "admin_s3_bucket" {
  description = "S3 bucket name for admin static artifacts"
  value       = aws_s3_bucket.admin.id
}
