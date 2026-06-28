import '../../../core/error/result.dart';

abstract class SyncRepository {
  Future<Result<void>> scheduleSync();
  Future<Result<int>> pendingCount();
  Future<Result<bool>> processQueue();
}
