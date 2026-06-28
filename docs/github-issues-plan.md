# GitHub Issues Plan

## Epic 1: Backend Foundation

- [ ] Setup Quarkus project with Panache + PostgreSQL
- [ ] JWT auth with SmallRye and refresh-token rotation
- [ ] User CRUD with roles and soft delete
- [ ] Questionnaire CRUD with JSONB multilingual fields
- [ ] Excel import with Apache POI and validation
- [ ] Excel export for responses using SXSSF streaming
- [ ] Survey and Response endpoints with idempotent batch sync
- [ ] Quarkus REST tests with `@TestSecurity`
- [ ] Docker Compose local dev stack

## Epic 2: Flutter Mobile

- [ ] Project setup with Drift + sqlite3_flutter_libs + WAL mode
- [ ] Login screen and secure JWT storage
- [ ] Questionnaire list and local cache
- [ ] Dynamic survey form rendering
- [ ] Single choice widget
- [ ] Multi select widget
- [ ] Long text widget
- [ ] Offline draft saving
- [ ] Sync queue with WorkManager exponential backoff and max 5 retries
- [ ] Sync status UI

## Epic 3: Admin Dashboard

- [ ] React + TypeScript + Vite setup
- [ ] Login page with JWT storage
- [ ] Upload page with validation preview
- [ ] Questionnaire list and preview
- [ ] Response export page
- [ ] Surveyor management page
- [ ] Dashboard stats

## Epic 4: DevOps and QA

- [ ] Docker Compose local dev
- [ ] GitHub Actions CI (backend tests, admin build, Flutter build)
- [ ] AWS deployment scripts
- [ ] Load testing
- [ ] Field testing with surveyors
