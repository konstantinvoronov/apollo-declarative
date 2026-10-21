import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:app_failure/app_failure.dart';
import '../domain/services/i_app_logger_service.dart';

/// AppLogger - базовый логгер всех процессов прилы. стоит выше чем DI вызывается первым.
class AppLoggerService implements IAppLoggerService {
  static final AppLoggerService _instance = AppLoggerService._();
  factory AppLoggerService() => _instance;
  AppLoggerService._();

  File? _logFile;
  File? _crashFlagFile;

  // Single sink + queue to serialize writes
  IOSink? _sink;
  final _queue = StreamController<FutureOr<void> Function()>();
  final _initCompleter = Completer<void>();

  final Map<String, DateTime> _benchmarks = {};

  bool logAllBenchmarks = false;
  Duration slowThreshold = const Duration(milliseconds: 5000); // fix

  Future<void> init() async {
    if (_initCompleter.isCompleted) return; // init already done
    try {
      final dir = await getApplicationDocumentsDirectory();
      _logFile = File('${dir.path}/session_log.txt');
      _crashFlagFile = File('${dir.path}/crash_flag');

      bool prevWasClean = false;
      if (_crashFlagFile!=null && await _crashFlagFile!.exists()) {
        try {
          final contents = (await _crashFlagFile!.readAsString()).trim();
          prevWasClean = contents == 'CLEAN';
        } catch (_) {
          prevWasClean = false;
        }
      }

      if (prevWasClean) {
        cleanLog();
      } else {
      }

      await _logFile!.writeAsString(
        '\n===== SESSION ${DateTime.now().toIso8601String()} =====\n',
        mode: FileMode.append,
        flush: true,
      );

      await _crashFlagFile!.writeAsString('UNCLEAN', flush: true);

      _sink = _logFile!.openWrite(mode: FileMode.append);
      _queue.stream.asyncMap((operation) async {
        await operation();
      }).listen((_) {});

      _initCompleter.complete();
    } catch (e, st) {
      if (!_initCompleter.isCompleted) {
        _initCompleter.completeError(e, st);
      }
      rethrow;
    }
  }

  Future<void> dispose() async {
    await _queue.close();
    await _sink?.flush();
    await _sink?.close();
  }

  Future<void> log(String message, [String logName = "apollo"]) async {
    await _initCompleter.future; // ensure ready
    final ts = DateTime.now().toIso8601String();
    final line = '[$ts] $logName $message\n';
    if (kDebugMode) debugPrint('[$logName] $message');
    _queue.add(() { _sink!.write(line); }); // enqueue; single sink serializes writes
    // Optionally force flush for critical logs:
    // await _sink?.flush();
  }

  Future<void> logFailure(AppFailure failure, {String? context}) async {
    final s = failure.toString();
    // Use debugPrint to avoid truncating long multi-line failures.
    debugPrint(s);
    final prefix =
        (context != null && context.isNotEmpty) ? '[Context] $context\n' : '';
    await log('$prefix$s');
  }

  Future<T> bm<T>(Future<T> future, {required String id}) async {
    await benchMarkStart(id);
    try {
      return await future;
    } finally {
      await benchMarkComplete(id);
    }
  }

  Future<void> benchMarkStart(String id) async {
    final now = DateTime.now();
    final traceId = Zone.current['traceId']?.toString();
    final fullId = traceId != null ? '$id [traceId=$traceId]' : id;
    _benchmarks[fullId] = now;
    if (logAllBenchmarks) {
      await log('[BENCHMARK START] $fullId at ${now.toIso8601String()}');
    }
  }

  Future<void> benchMarkComplete(String id) async {
    final traceId = Zone.current['traceId']?.toString();
    final fullId = traceId != null ? '$id [traceId=$traceId]' : id;

    final now = DateTime.now();
    final start = _benchmarks.remove(fullId);

    if (start != null) {
      final duration = now.difference(start);
      final ms = duration.inMilliseconds;
      if (duration >= slowThreshold) {
        final msg = 'Benchmark $fullId took $ms ms, exceeding ${slowThreshold.inMilliseconds} ms.';
        await logFailure(AppFailure.performanceFailure(msg), context: 'benchMarkComplete');
      } else if (logAllBenchmarks) {
        await log('[BENCHMARK COMPLETE] $fullId in $ms ms');
      }
    } else {
      await log('[BENCHMARK MISSING] No start found for $fullId');
    }
  }

  Future<void> markCleanExit() async {
    await _initCompleter.future;
    await _crashFlagFile!.writeAsString('CLEAN', flush: true);
    await _sink?.flush();
  }

  Future<void> unmarkCleanExit() async {
    await _initCompleter.future;
    await _crashFlagFile!.writeAsString('UNCLEAN', flush: true);
  }

  Future<bool> wasLastSessionCrash() async {
    try {
      final contents = await _crashFlagFile!.readAsString();
      return contents.trim() != 'CLEAN';
    } catch (_) {
      return false;
    }
  }

  // Expose file safely
  File? get logFile => _logFile;

  @override
  Future<AppResult<String>> snapshotLog() async {
    try {
      await _initCompleter.future;
      final snapshot = Completer<AppResult<String>>();
      _queue.add(() async {
        try {
          await _sink!.flush();
          snapshot.complete(AppResult.success(await _logFile!.readAsString()));
        } catch (error, stackTrace) {
          snapshot.complete(AppResult.failure(AppFailure.unhandledFailure(
            logMessage: 'Logger snapshot failed',
            error: error,
            stackTrace: stackTrace,
          )));
        }
      });
      return await snapshot.future;
    } catch (error, stackTrace) {
      return AppResult.failure(AppFailure.unhandledFailure(
        logMessage: 'Logger snapshot failed',
        error: error,
        stackTrace: stackTrace,
      ));
    }
  }

  Future<void> cleanLog() async {
    if (_logFile == null) return;

    // Read the whole log file
    final content = await _logFile!.readAsString();

    // Split into lines
    final lines = content.split('\n');

    // Keep only the last 200 lines
    final lastLines = lines.length > 200
        ? lines.sublist(lines.length - 200)
        : lines;

    // Write back to file
    await _logFile!.writeAsString(
      lastLines.join('\n'),
      mode: FileMode.write,
      flush: true,
    );
  }}
