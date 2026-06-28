# Voter Sentiment Analysis Platform

A field-ready voter sentiment collection system built for Indian constituencies.

## Monorepo Layout

```
voter-sentiment-platform/
├── backend/      Quarkus 3.x + Hibernate ORM Panache + PostgreSQL
├── mobile/       Flutter + Drift + WorkManager (offline-first)
├── admin/        React + TypeScript dashboard
├── docs/         Architecture and runbooks
├── scripts/      Local setup and deployment helpers
├── docker-compose.yml
└── README.md
```

## Quick Start

```bash
# 1. Bootstrap all modules
bash scripts/init-monorepo.sh

# 2. Configure environment variables
bash scripts/setup-env.sh

# 3. Start local infrastructure
bash scripts/dev.sh

# 4. Seed an admin user
bash scripts/db-seed.sh
```

## Modules

- **Backend** — REST API, JWT auth, questionnaire CRUD, Excel import/export, survey sync.
- **Mobile** — Offline-first Flutter app with dynamic questionnaires and background sync.
- **Admin** — React dashboard for upload, preview, activation, export, and user management.

## Documentation

- [Architecture](docs/architecture.md)
- [API Endpoints](docs/api-endpoints.md)
- [Database Schema](docs/database-schema.md)
- [Excel Format](docs/excel-format.md)
- [Deployment](docs/deployment.md)
- [Future Scope](docs/future-scope.md)

## License

MIT
