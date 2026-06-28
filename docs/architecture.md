# Architecture

## Overview

The Voter Sentiment Analysis Platform is a three-tier, offline-first system for collecting structured survey data in the field.

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│   Mobile    │────▶│  Backend API │────▶│  PostgreSQL │
│  Flutter    │     │   Quarkus    │     │    Redis    │
└─────────────┘     └──────────────┘     └─────────────┘
       │                     │
       │ Drift + SQLite      │ S3 (future)
       │ WorkManager         │ SmallRye JWT
       └─────────────────────┘
```

## Backend

- Quarkus 3.x with Hibernate ORM Panache repository pattern.
- SmallRye JWT for stateless auth with role-based access control.
- PostgreSQL JSONB for multilingual text and options.
- Apache POI for Excel import/export; streaming SXSSF for exports.
- Idempotent batch sync endpoint for zero data loss.

## Mobile

- Flutter with offline-first Drift + SQLite (WAL mode).
- WorkManager background sync with exponential backoff and max 5 retries.
- Secure storage for JWT tokens.
- Dynamic question rendering based on questionnaire schema.

## Admin

- React + TypeScript + Vite.
- React Query for data fetching, react-hook-form for forms, Ant Design for UI.
- Protected routes and JWT auth.
