# Field Testing Plan

## Goal
Validate the mobile app in real surveyor conditions: unreliable networks, device sleep, GPS capture, and offline-first data collection.

## Participants
- 3–5 field surveyors
- 1 supervisor with admin dashboard access

## Devices
- Android phones (minimum 2 GB RAM)
- Mix of network conditions: 4G, intermittent Wi-Fi, offline

## Test Scenarios

### 1. Offline questionnaire completion
1. Surveyor logs in while online.
2. Questionnaires are cached locally.
3. Turn on airplane mode.
4. Complete 5 surveys offline.
5. Verify surveys show as **Pending** in the sync queue.
6. Turn airplane mode off.
7. Trigger sync and confirm surveys move to **Synced**.

### 2. App kill and restart mid-survey
1. Start a survey.
2. Answer two questions.
3. Force-close the app.
4. Reopen the app and resume the questionnaire.
5. Acceptable: current implementation saves only on submit; note if data loss occurs.

### 3. Background sync with device sleep
1. Queue pending surveys.
2. Lock the phone and wait 15 minutes.
3. Confirm WorkManager attempts sync and reflects status in the UI.

### 4. GPS capture
1. Complete a survey that requests GPS.
2. Verify GPS coordinates are stored and visible in the backend export.

### 5. Retry and permanent failure
1. Configure backend to return 500 for batch sync.
2. Attempt sync 5 times.
3. Verify the survey is marked **FAILED_PERMANENT** and not retried again.
4. Restore backend and confirm a fresh survey syncs normally.

## Feedback Capture

After each session, collect:
- Time to complete one survey
- Number of sync failures and recoveries
- Battery usage estimate
- User confusion points (question wording, navigation, GPS prompts)
- Device/OS versions used

## Success Criteria
- Zero unrecoverable data loss
- Pending surveys sync automatically when connectivity returns
- p95 survey completion time < 3 minutes
- All GPS-capturing surveys include valid coordinates

## Reporting
Compile findings into `docs/field-testing-report-YYYY-MM-DD.md` and open follow-up issues for any blockers.
