# Introspection, Self-Interview, and Retrospection

## What I assumed at the start

1. The MVP can use a single JWT as both access and refresh token.
2. Drift + `drift_sqflite` would automatically give us WAL mode.
3. A simple retry loop inside WorkManager is enough for "zero data loss".
4. `XSSFWorkbook` is fine for all Excel operations because the spec says "up to 500 rows".
5. Surveys are immutable once submitted, so duplicate submissions are not a real risk.
6. Soft delete can be deferred because the data model did not include a `deleted_at` column.

## Research findings that challenge those assumptions

### 1. JWT storage and refresh-token hygiene

- JWT payloads are only base64-encoded, not encrypted; storing them in plain shared preferences leaks claims.
- OWASP recommends refresh-token rotation with reuse detection (or sender-constraining via DPoP/mTLS).
- Without rotation, a stolen long-lived refresh token can be replayed until expiry.
- `flutter_secure_storage` maps to Android Keystore / iOS Keychain, which is the correct minimum bar.

### 2. Hibernate 6 JSONB mapping

- `@JdbcTypeCode(SqlTypes.JSON)` is the canonical Hibernate 6 way to map to PostgreSQL `jsonb`.
- No extra dependency such as `hypersistence-utils` is required.
- For collections or maps, `SqlTypes.JSON` still works as long as the type is serializable by Jackson.

### 3. Drift WAL mode

- WAL is not enabled by default; it must be set via `PRAGMA journal_mode=WAL` in the database `setup` callback.
- `NativeDatabase.createInBackground` + `readPool` is the recommended pattern for concurrent reads/writes on mobile.
- `drift_sqflite` does not expose WAL configuration directly; we should depend on `drift` + `sqlite3_flutter_libs` + `path_provider`.

### 4. Offline-first sync first principles

- Mobile networks are bursty and devices sleep; retries must be persisted and idempotent.
- Last-Write-Wins (LWW) is acceptable when records are device-owned, but duplicate detection still needs idempotency keys.
- The client must generate and persist the idempotency key before the first network call; otherwise a crash creates a duplicate.
- For "zero data loss on sync retry", the server must replay the same response for the same key and never double-create records.

### 5. WorkManager retry behavior

- Exponential backoff doubles the delay each retry (start delay × 2^(attempt-1)), capped at `MAX_BACKOFF_MILLIS`.
- The worker must return `Result.retry()` explicitly; `setBackoffCriteria` alone does nothing.
- Enforcing a hard max of 5 retries is best done by checking `runAttemptCount` and returning `Result.failure()` afterwards.
- Constraints (`NetworkType.CONNECTED`, battery not required in our case) prevent useless attempts.

### 6. Apache POI memory

- `XSSFWorkbook` loads the whole workbook into memory.
- `SXSSFWorkbook` streams rows to disk and is the right choice for large response exports, even though the spec targets 500 rows per sheet.
- For import (parsing a user-supplied file), `XSSFWorkbook` is acceptable for the MVP size.

## Self-interview

**Q: Should we implement full refresh-token rotation with reuse detection in the MVP?**
A: Partial. We will store refresh tokens as secure random hashes in PostgreSQL, rotate them on every refresh, and invalidate a token family on reuse. This is feasible within the MVP schema and aligns with OWASP without requiring DPoP/mTLS complexity.

**Q: How do we guarantee zero data loss on sync retry?**
A: Three mechanisms:
1. Client assigns a UUID to every survey before local persistence.
2. Sync queue stores the payload and idempotency key durably in Drift.
3. Backend `batch-sync` endpoint stores processed idempotency keys atomically and returns the stored survey for duplicates.

**Q: What is our conflict-resolution strategy?**
A: Survey responses are append-only and owned by the originating device. We use idempotent create with server-authoritative record creation. If a duplicate arrives, the server returns the original record. No merge UI is needed for the MVP.

**Q: Why not use CRDTs or OT?**
A: The domain does not have concurrent editing of the same survey by multiple users. CRDTs would add complexity without solving a real MVP problem.

**Q: How do we keep p95 API latency under 500 ms?**
A: Database connection pooling, JSONB indexes only where queried (we mostly fetch by id/foreign key), streaming Excel export, and async sync logging. We avoid N+1 queries by fetching questionnaires with groups/questions in eager joins.

**Q: Is `drift_sqflite` still acceptable?**
A: No. We switch to `NativeDatabase` with explicit WAL pragmas to satisfy the requirement and production reliability.

## Changes to the implementation plan

1. **Backend auth**
   - Add `RefreshToken` Panache entity (token hash, user FK, expiry, family id, used flag).
   - `AuthService` issues access JWT + refresh token hash; rotation invalidates previous hash and detects reuse.
   - `POST /api/auth/refresh` rotates refresh token and returns new access token.

2. **Backend survey sync**
   - Add `client_id` (UUID) and `idempotency_key` to `Survey` entity.
   - Add `IdempotencyLog` table or use `Survey.client_id` as the natural idempotency key.
   - `batch-sync` endpoint returns per-survey status and the server-assigned survey id.

3. **Backend Excel export**
   - Use `SXSSFWorkbook` for response exports to handle larger-than-expected datasets.

4. **Flutter local database**
   - Replace `drift_sqflite` dependency plan with `drift` + `sqlite3_flutter_libs` + `path_provider`.
   - Implement `NativeDatabase.createInBackground` with `PRAGMA journal_mode=WAL` and `readPool: 2`.
   - Add periodic `PRAGMA wal_checkpoint(TRUNCATE)` on app foreground events.

5. **Flutter sync worker**
   - Enqueue unique work with `ExistingWorkPolicy.KEEP`.
   - Set `BackoffPolicy.EXPONENTIAL`, `Duration(seconds: 10)`.
   - Check `runAttemptCount` and fail permanently after 5 attempts.

6. **Flutter API client**
   - Dio interceptor stores access token in secure storage, attempts refresh on 401, and retries once.
   - On refresh failure, redirect to login.

7. **Testing**
   - Add `quarkus-test-security` dependency for `@TestSecurity`.
   - Add tests for idempotent batch sync and refresh-token rotation.

8. **Soft deletes**
   - Add `deletedAt` columns to `User` and `Questionnaire` and filter queries accordingly.

## What stays the same

- Technology stack remains as specified.
- Feature scope (voice excluded, v1.1 features excluded).
- Folder structure and module boundaries.
- Admin dashboard tech choices (React + Vite + Ant Design + React Query + react-hook-form + xlsx).

## Clarity statement

The biggest risk in the original plan was treating the sync layer as a simple retry loop rather than an idempotent, durable operation queue. The revised plan makes idempotency and token rotation first-class citizens while keeping the implementation minimal enough for the MVP.

## Second-pass introspection (deeper unknowns)

After generating the first cut, additional first-principles gaps surfaced:

### 1. RESTEasy Reactive + blocking Hibernate ORM Panache

- `quarkus-rest` (RESTEasy Reactive) runs requests on the Vert.x event loop by default.
- Calling blocking JDBC/Hibernate on the event loop is unsafe and harms throughput.
- The canonical fix is to annotate blocking resources with `@Blocking` so Quarkus dispatches them to a worker thread.
- This keeps the simple `@Transactional` / Panache repository model intact without migrating to Hibernate Reactive.

### 2. SmallRye JWT private-key format

- `Jwt.sign()` expects a PKCS#8 private key (`-----BEGIN PRIVATE KEY-----`).
- `openssl genrsa` produces PKCS#1 (`-----BEGIN RSA PRIVATE KEY-----`), which causes `SRJWT05028: Signing key can not be created from the loaded content`.
- The dev keys must be converted: `openssl pkcs8 -topk8 -nocrypt`.

### 3. Nginx runtime environment variables in a static React container

- Vite bakes environment variables at build time.
- Passing `VITE_API_BASE_URL` at container runtime has no effect unless the built artifacts are mutated or Nginx substitutes a placeholder.
- The correct pattern is an `nginx.conf.template` + `envsubst` at container startup, producing `/etc/nginx/conf.d/default.conf`.

### 4. WorkManager retry semantics vs. per-item max retries

- WorkManager’s exponential backoff schedules the *task*, not individual surveys.
- The `executeTask` callback does not receive `runAttemptCount` in the Flutter API, so max-5-retries must be tracked per survey in the local database.
- We added `attemptCount` to `SurveyDraftTable`; after 5 failures the survey is marked `FAILED_PERMANENT` and skipped.

## Changes applied in second pass

1. Added `@Blocking` to all REST resource classes to keep Hibernate ORM on worker threads.
2. Converted `backend/src/main/resources/privateKey.pem` to PKCS#8 format.
3. Replaced `admin/nginx.conf` with `nginx.conf.template` and updated the admin Dockerfile to run `envsubst` on startup.
4. Added `API_BASE_URL` runtime environment variable to `docker-compose.yml` for the admin service.
5. Added `attemptCount` to `SurveyDraftTable` and enforced a hard max of 5 retries in the sync worker.
6. Updated `processQueue` to return `Result<bool>` so the worker can signal whether a retry is still needed.

## Remaining risks to watch

- Drift code generation must be run (`flutter pub run build_runner build`) before the mobile app compiles.
- Soft-delete filters and pagination need integration tests under load.
- Kong/AWS API Gateway rate-limiting policies are still out of scope and must be configured at the infrastructure layer.
