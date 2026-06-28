# Deployment

## Local development

```bash
bash scripts/dev.sh
```

This starts PostgreSQL, Redis, backend, and admin UI via Docker Compose.

## AWS production (outline)

1. RDS PostgreSQL 14+ with JSONB.
2. ElastiCache Redis 7+.
3. ECR/ECS or EKS for Quarkus backend containers.
4. S3 for audio/Excel exports.
5. API Gateway or Kong for rate limiting and routing.
6. CloudFront + S3 for static admin dashboard.
7. GitHub Actions for CI/CD.

## Environment variables

See `backend/.env.example` and `admin/.env.example`.
