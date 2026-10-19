import 'package:app_failure/app_failure.dart';

import '../models/settings_key.dart';

abstract interface class IAppSettingsRepository {
  AppResult<T> get<T>(
    SettingsKey key, {
    String? sessionId,
  });

  Future<AppResult<bool>> set(
    SettingsKey key,
    Object? value, {
    String? sessionId,
  });

  Future<AppResult<String>> newSession(
    String newSessionId,
    SettingsKey sessionKey,
  );

  Future<AppResult<int>> clearSession(String sessionId);
}
