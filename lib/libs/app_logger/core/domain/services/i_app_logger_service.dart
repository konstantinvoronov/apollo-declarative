import 'dart:io';

import 'package:app_failure/app_failure.dart';

abstract interface class IAppLoggerService {
  bool get logAllBenchmarks;
  set logAllBenchmarks(bool value);

  Duration get slowThreshold;
  set slowThreshold(Duration value);

  Future<void> init();
  Future<void> dispose();
  Future<void> log(String message, [String logName = "apollo"]);
  Future<void> logFailure(AppFailure failure, {String? context});
  Future<T> bm<T>(Future<T> future, {required String id});
  Future<void> benchMarkStart(String id);
  Future<void> benchMarkComplete(String id);
  Future<void> markCleanExit();
  Future<void> unmarkCleanExit();
  Future<bool> wasLastSessionCrash();
  File? get logFile;
  Future<AppResult<String>> snapshotLog();
  Future<void> cleanLog();
}
