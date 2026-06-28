import 'package:workmanager/workmanager.dart';

import 'data/sync_repository_impl.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // Per-survey retry enforcement is tracked locally in SurveyDraftTable.attemptCount.
    final success = await SyncRepositoryImpl.executeBackgroundSync();
    return Future.value(success);
  });
}
