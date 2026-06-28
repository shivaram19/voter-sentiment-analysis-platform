import 'package:flutter/material.dart';

class SyncStatusBanner extends StatelessWidget {
  final int pendingCount;
  final bool isSyncing;

  const SyncStatusBanner({super.key, required this.pendingCount, this.isSyncing = false});

  @override
  Widget build(BuildContext context) {
    if (pendingCount == 0 && !isSyncing) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      color: isSyncing ? Colors.orange.shade100 : Colors.blue.shade100,
      padding: const EdgeInsets.all(12),
      child: Text(
        isSyncing
            ? 'Syncing $pendingCount pending surveys...'
            : '$pendingCount survey(s) pending sync',
        textAlign: TextAlign.center,
      ),
    );
  }
}
