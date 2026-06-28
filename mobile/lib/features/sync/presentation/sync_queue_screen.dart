import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/error/result.dart';
import '../domain/sync_repository.dart';
import 'widgets/sync_status_banner.dart';

final syncRepositoryProvider = Provider<SyncRepository>((ref) => getIt<SyncRepositoryImpl>());

class SyncQueueScreen extends ConsumerStatefulWidget {
  const SyncQueueScreen({super.key});

  @override
  ConsumerState<SyncQueueScreen> createState() => _SyncQueueScreenState();
}

class _SyncQueueScreenState extends ConsumerState<SyncQueueScreen> {
  bool _syncing = false;
  int _pending = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPending();
  }

  Future<void> _loadPending() async {
    final repo = ref.read(syncRepositoryProvider);
    final result = await repo.pendingCount();
    if (mounted) {
      setState(() {
        switch (result) {
          case Success<int>(data: final count):
            _pending = count;
            _error = null;
          case Error<int>(failure: final failure):
            _error = failure.message;
        }
      });
    }
  }

  Future<void> _syncNow() async {
    setState(() => _syncing = true);
    final repo = ref.read(syncRepositoryProvider);
    final result = await repo.processQueue();
    if (mounted) {
      setState(() => _syncing = false);
      switch (result) {
        case Success<bool>(data: final allDone):
          _error = allDone ? null : 'Some surveys failed and will retry later.';
        case Error<bool>(failure: final failure):
          _error = failure.message;
      }
      await _loadPending();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sync Queue')),
      body: Column(
        children: [
          SyncStatusBanner(pendingCount: _pending, isSyncing: _syncing),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ),
          Expanded(
            child: Center(
              child: _pending == 0
                  ? const Text('All surveys are synced.')
                  : ElevatedButton(
                      onPressed: _syncing ? null : _syncNow,
                      child: const Text('Sync Now'),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
