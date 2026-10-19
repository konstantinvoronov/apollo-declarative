import 'dart:convert';
import 'package:app_failure/app_failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/models/settings_key.dart';
import '../../domain/models/settings_key_type.dart';
import '../../domain/repositories/i_app_settings_repository.dart';

class AppSettingsRepository implements IAppSettingsRepository {
  AppSettingsRepository(this._prefs);
  final SharedPreferences _prefs;

  /// Namespacing helper: session-scoped keys => 'session:<id>:<key>'
  String _ns(String raw, String? sessionId) =>
      sessionId == null ? raw : 'session:$sessionId:$raw';

  /// Get by SettingsKey; optionally session-scoped.
  @override
  AppResult<T> get<T>(SettingsKey key, {String? sessionId}) {
    try {
      final k = _ns(key.keyName, sessionId);
      switch (key.keyType) {
        case SettingsKeyType.string:
          final v = _prefs.getString(k);
          if (v == null) return (key.defaultValue!=null) ? AppResult.success(key.defaultValue) : AppResult.failure(_missing(key, k));
          return AppResult.success(v as T);
        case SettingsKeyType.int:
          final v = _prefs.getInt(k);
          if (v == null) return (key.defaultValue!=null) ? AppResult.success(key.defaultValue) : AppResult.failure(_missing(key, k));
          return AppResult.success(v as T);
        case SettingsKeyType.bool:
          final v = _prefs.getBool(k);
          if (v == null) return (key.defaultValue!=null) ? AppResult.success(key.defaultValue) : AppResult.failure(_missing(key, k));
          return AppResult.success(v as T);
        case SettingsKeyType.json:
          final s = _prefs.getString(k);
          if (s == null) return (key.defaultValue!=null) ? AppResult.success(key.defaultValue) : AppResult.failure(_missing(key, k));
          final decoded = jsonDecode(s);
          return AppResult.success(decoded as T);
      }
    } catch (e, st) {
      return AppResult.failure(AppFailure.repositoryFailure(
        uiMessage: 'Could not read setting',
        logMessage: 'AppSettings.get failed for ${key.keyName}',
        cause: e,
        stackTrace: st,
      ));
    }
  }

  /// Strict async set; awaits persistence and returns success/failure.
  @override
  Future<AppResult<bool>> set(SettingsKey key, Object? value, {String? sessionId}) async {
    try {
      final k = _ns(key.keyName, sessionId);
      bool ok;
      switch (key.keyType) {
        case SettingsKeyType.string:
          ok = await _prefs.setString(k, (value ?? '') as String);
          break;
        case SettingsKeyType.int:
          ok = await _prefs.setInt(k, (value ?? 0) as int);
          break;
        case SettingsKeyType.bool:
          ok = await _prefs.setBool(k, (value ?? false) as bool);
          break;
        case SettingsKeyType.json:
          ok = await _prefs.setString(k, jsonEncode(value));
          break;
      }
      if (!ok) {
        return AppResult.failure(AppFailure.repositoryFailure(
          uiMessage: 'Could not save setting',
          logMessage: 'AppSettings.setAsync failed for $k', stackTrace: StackTrace.current,
        ));
      }
      return const AppResult.success(true);
    } catch (e, st) {
      return AppResult.failure(AppFailure.repositoryFailure(
        uiMessage: 'Could not save setting',
        logMessage: 'AppSettings.setAsync exception for ${key.keyName}',
        cause: e,
        stackTrace: st,
      ));
    }
  }

  /// Create/update session id key (not namespaced).
  @override
  Future<AppResult<String>> newSession(String newSessionId, SettingsKey sessionKey) async {
    try {
      final ok = await _prefs.setString(sessionKey.keyName, newSessionId);
      if (!ok) {
        return AppResult.failure(AppFailure.repositoryFailure(
            uiMessage: 'Could not persist session id',
            logMessage: 'AppSettings.newSession setString=false',
          stackTrace: StackTrace.current,
        ));
      }
      return AppResult.success(newSessionId);
    } catch (e, st) {
      return AppResult.failure(AppFailure.repositoryFailure(
        uiMessage: 'Could not start new session',
        logMessage: 'AppSettings.newSession failed',
        cause: e,
        stackTrace: st,
      ));
    }
  }

  /// Remove all keys for the given session. Returns number of removed keys.
  @override
  Future<AppResult<int>> clearSession(String sessionId) async {
    try {
      final prefix = 'session:$sessionId:';
      final keys = _prefs.getKeys().where((k) => k.startsWith(prefix)).toList();
      var removed = 0;
      for (final k in keys) {
        final ok = await _prefs.remove(k);
        if (!ok) {
          throw AppFailure.repositoryFailure(
            uiMessage: 'Could not clear session data',
            logMessage: 'Could not remove session key: $k',
            stackTrace: StackTrace.current,
          );
        }
        removed++;
      }
      return AppResult.success(removed);
    } catch (e, st) {
      return AppResult.failure(AppFailure.repositoryFailure(
        uiMessage: 'Could not clear session data',
        logMessage: 'AppSettings.clearSession failed',
        cause: e,
        stackTrace: st,
      ));
    }
  }

  AppFailure _missing(SettingsKey key, String resolvedKey) =>
      AppFailure.repositoryFailure(
        uiMessage: 'Setting not found',
        logMessage: 'Missing key: ${key.keyName} (resolved: $resolvedKey)',
        stackTrace: StackTrace.current
      );
}
