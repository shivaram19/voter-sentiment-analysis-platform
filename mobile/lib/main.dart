import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';

import 'app.dart';
import 'core/di/service_locator.dart';
import 'features/sync/data/sync_repository_impl.dart';
import 'features/sync/sync_worker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await Workmanager().initialize(callbackDispatcher);
  await getIt<SyncRepositoryImpl>().scheduleSync();
  runApp(const ProviderScope(child: VoterSentimentApp()));
}
