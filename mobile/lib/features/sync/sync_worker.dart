import 'package:workmanager/workmanager.dart';

import 'data/sync_repository_impl.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Max retry enforcement is handled by WorkManager runAttemptCount.
    if (inputData != null && (inputData['attempt'] ?? 0) > 5) {
      return Future.value(false);
    }
    final success = await SyncRepositoryImpl.executeBackgroundSync();
    return Future.value(success);
  });
}
