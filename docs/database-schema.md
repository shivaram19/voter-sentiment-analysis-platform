# Database Schema

## Tables

- `app_user` — administrators, supervisors, surveyors.
- `refresh_token` — hashed refresh tokens with rotation and reuse detection.
- `questionnaire` — title, description, language support (JSONB), soft delete.
- `question_group` — grouping of questions within a questionnaire.
- `question` — multilingual text, type, options (JSONB), skip logic (JSONB).
- `survey` — respondent info, GPS, sync status, client survey id for idempotency.
- `survey_response` — answers as JSONB.
- `sync_log` — per-survey sync attempts.
- `import_log` / `export_log` — audit logs for Excel operations.

## Key constraints

- Unique `(surveyor_id, client_survey_id)` on `survey` to prevent duplicates.
- Soft deletes via `deleted_at` on `app_user` and `questionnaire`.
