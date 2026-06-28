# API Endpoints

All endpoints are prefixed with `/api`.

## Auth

- `POST /auth/login`
- `POST /auth/register` (ADMIN only)
- `POST /auth/refresh`
- `GET /auth/me`

## Admin Questionnaire

- `POST /admin/questionnaire/upload`
- `POST /admin/questionnaire/save`
- `GET /admin/questionnaire/questionnaires`
- `GET /admin/questionnaire/{id}`
- `PUT /admin/questionnaire/{id}`
- `PUT /admin/questionnaire/{id}/activate`
- `PUT /admin/questionnaire/{id}/deactivate`
- `DELETE /admin/questionnaire/{id}`
- `GET /admin/questionnaire/{id}/export-template`
- `GET /admin/questionnaire/{id}/export-responses`

## Admin Users & Stats

- `GET /admin/dashboard/stats`
- `GET /admin/users`
- `POST /admin/users`
- `PUT /admin/users/{id}`
- `DELETE /admin/users/{id}`

## Surveyor

- `GET /surveyor/questionnaires`
- `GET /surveyor/questionnaire/{id}/full`

## Survey

- `POST /survey/start`
- `POST /survey/{id}/response`
- `POST /survey/{id}/complete`
- `POST /survey/batch-sync`
- `GET /survey/{id}`

## Health

- `GET /health`
- `GET /health/live`
- `GET /health/ready`
