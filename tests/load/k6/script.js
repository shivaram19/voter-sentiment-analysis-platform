import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 10 },
    { duration: '1m', target: 50 },
    { duration: '30s', target: 0 },
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.05'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://localhost:8080/api';

function registerAndLogin() {
  const username = `surveyor_${__VU}_${Date.now()}`;
  const password = 'password123';

  const registerRes = http.post(`${BASE_URL}/auth/register`, JSON.stringify({
    username,
    password,
    name: 'Load Tester',
    role: 'SURVEYOR',
  }), { headers: { 'Content-Type': 'application/json' } });

  check(registerRes, {
    'register status is 200 or 409': (r) => r.status === 200 || r.status === 409,
  });

  const loginRes = http.post(`${BASE_URL}/auth/login`, JSON.stringify({
    username,
    password,
  }), { headers: { 'Content-Type': 'application/json' } });

  check(loginRes, {
    'login status is 200': (r) => r.status === 200,
    'login returns access token': (r) => r.json('data.accessToken') !== undefined,
  });

  return loginRes.json('data.accessToken');
}

export default function () {
  const token = registerAndLogin();

  const listRes = http.get(`${BASE_URL}/admin/questionnaire/questionnaires?page=0&size=10`, {
    headers: { Authorization: `Bearer ${token}` },
  });

  check(listRes, {
    'list questionnaires status is 200': (r) => r.status === 200,
  });

  const clientSurveyId = `client-${__VU}-${Date.now()}`;
  const syncRes = http.post(`${BASE_URL}/survey/batch-sync`, JSON.stringify({
    surveys: [
      {
        clientSurveyId,
        questionnaireId: '00000000-0000-0000-0000-000000000001',
        languageUsed: 'en',
        responses: [
          {
            questionId: '00000000-0000-0000-0000-000000000002',
            responseType: 'SINGLE_CHOICE',
            responseValue: 'option_a',
          },
        ],
      },
    ],
  }), {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`,
    },
  });

  check(syncRes, {
    'batch sync status is 200': (r) => r.status === 200,
    'batch sync returns SYNCED or ALREADY_SYNCED': (r) =>
      r.json('data.0.status') === 'SYNCED' || r.json('data.0.status') === 'ALREADY_SYNCED',
  });

  sleep(1);
}
