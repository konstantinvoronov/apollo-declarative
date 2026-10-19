import 'dart:async';

import 'package:app_failure/app_failure.dart';
import 'package:stateful_data/stateful_data.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/settings_key.dart';
import '../../domain/models/settings_key_type.dart';
import '../../domain/repositories/i_app_settings_repository.dart';
import '../../domain/params/app_session_params.dart';
import '../../domain/repositories/i_app_session_repository.dart';

// AppSession - содержит переменные относительно текущей сессии -
/// all params are stored for a specific sessionId when we close or renew session all data removed
class AppSessionRepository implements IAppSessionRepository {
  AppSessionRepository(this._settings);

  static const _sessionIdKey = SettingsKey<String>(
    keyName: 'sessionId',
    keyType: SettingsKeyType.string,
    defaultValue: '',
  );

  final IAppSettingsRepository _settings;
  final _sessions =
      StreamController<StatefulData<String, AppFailure>>.broadcast();
  final Map<
    ({String? sessionId, String keyName, bool onlyMemory}),
    StatefulData<Object?, AppFailure>
  >
  _memory = {};
  StatefulData<String, AppFailure> _state = const Uninitialized();
  Future<void> _pendingWrites = Future<void>.value();

  @override
  StatefulData<String, AppFailure> get state => _state;

  @override
  Stream<StatefulData<String, AppFailure>> get sessions => _sessions.stream;

  @override
  Future<AppResult<String>> initialize() => _inWriteOrder(() async {
    try {
      if (_sessions.isClosed) throw StateError('Session repository is closed');
      switch (_state) {
        case Ready(value: final sessionId):
          return AppResult.success(sessionId);
        case Uninitialized() || Failure():
          break;
        case Loading() || Updating() || Dirty() || Empty():
          throw StateError(
            'Session identity is not available for initialization',
          );
      }
      _publishSessionState(_state.toLoading());
      var sessionId = _settings
          .get<String>(_sessionIdKey)
          .fold((value) => value, (failure) => throw failure);
      if (sessionId.isEmpty) {
        sessionId = (await _settings.newSession(
          const Uuid().v4(),
          _sessionIdKey,
        )).fold((value) => value, (failure) => throw failure);
      }
      _publishSessionState(Ready(sessionId));
      return AppResult.success(sessionId);
    } catch (error, stackTrace) {
      final failure = _failureForOperation(
        'initialize',
        error,
        stackTrace,
        fatalLevel: FatalLevel.appFatal,
      );
      if (!_sessions.isClosed) {
        _publishSessionState(_state.toFailure(failure));
      }
      return AppResult.failure(failure);
    }
  });

  @override
  Future<AppResult<bool>> set<T>(
    AppSessionParams<T> params,
    T value,
  ) => _inWriteOrder(() async {
    try {
      final sessionId = _sessionIdForOperation().fold(
        (value) => value,
        (failure) => throw failure,
      );
      if (!params.sessionDependent && params.keyName == _sessionIdKey.keyName) {
        throw ArgumentError('sessionId is reserved for session identity');
      }
      final key = (
        sessionId: params.sessionDependent ? sessionId : null,
        keyName: params.keyName,
        onlyMemory: params.onlyMemory,
      );
      if (params.onlyMemory) {
        _memory[key] = Ready(value);
        return const AppResult.success(true);
      }
      _memory[key] = Updating(value, previous: _memory[key]);
      try {
        final saved = (await _settings.set(
          params.settingsKey,
          value,
          sessionId: key.sessionId,
        )).fold((value) => value, (failure) => throw failure);
        if (!saved) throw StateError('Settings repository rejected the write');
        return const AppResult.success(true);
      } finally {
        _memory.remove(key);
      }
    } catch (error, stackTrace) {
      return AppResult.failure(
        _failureForOperation('set ${params.keyName}', error, stackTrace),
      );
    }
  });

  @override
  AppResult<T> get<T>(AppSessionParams<T> params) {
    try {
      final sessionId = _sessionIdForOperation().fold(
        (value) => value,
        (failure) => throw failure,
      );
      if (!params.sessionDependent && params.keyName == _sessionIdKey.keyName) {
        throw ArgumentError('sessionId is reserved for session identity');
      }
      final key = (
        sessionId: params.sessionDependent ? sessionId : null,
        keyName: params.keyName,
        onlyMemory: params.onlyMemory,
      );
      if (_memory[key] case final cached?) {
        return switch (cached) {
          Ready(value: final value) => AppResult.success(value as T),
          Failure(:final failure) => throw failure,
          Uninitialized() ||
          Loading() ||
          Updating() ||
          Dirty() ||
          Empty() => throw StateError(
            'Session parameter ${params.keyName} is not ready',
          ),
        };
      }
      if (params.onlyMemory) {
        return AppResult.success(params.defaultValue as T);
      }
      final value = _settings
          .get<T>(params.settingsKey, sessionId: key.sessionId)
          .fold((value) => value, (failure) => throw failure);
      _memory[key] = Ready(value);
      return AppResult.success(value);
    } catch (error, stackTrace) {
      return AppResult.failure(
        _failureForOperation('get ${params.keyName}', error, stackTrace),
      );
    }
  }

  @override
  Future<AppResult<String>> renewSession() => _inWriteOrder(() async {
    try {
      final previousId = _sessionIdForOperation().fold(
        (value) => value,
        (failure) => throw failure,
      );
      _publishSessionState(_state.toUpdating(previousId));
      _memory.removeWhere((key, _) => key.sessionId == previousId);
      (await _settings.clearSession(
        previousId,
      )).fold((_) {}, (failure) => throw failure);
      final sessionId = (await _settings.newSession(
        const Uuid().v4(),
        _sessionIdKey,
      )).fold((value) => value, (failure) => throw failure);
      _publishSessionState(Ready(sessionId));
      return AppResult.success(sessionId);
    } catch (error, stackTrace) {
      final failure = _failureForOperation('renewSession', error, stackTrace);
      if (!_sessions.isClosed) {
        _publishSessionState(_state.toFailure(failure));
      }
      return AppResult.failure(failure);
    }
  });

  @override
  Future<AppResult<void>> dispose() => _inWriteOrder(() async {
    try {
      if (_sessions.isClosed) return const AppResult.success(null);
      final sessionId = switch (_state) {
        Ready(value: final id) || Failure(prev: final id?) => id,
        Uninitialized() || Failure(prev: null) => null,
        Loading() || Updating() || Dirty() || Empty() => throw StateError(
          'Session identity is not available for disposal',
        ),
      };
      if (sessionId != null) {
        _publishSessionState(_state.toUpdating(sessionId));
        _memory.removeWhere((key, _) => key.sessionId == sessionId);
        (await _settings.clearSession(
          sessionId,
        )).fold((_) {}, (failure) => throw failure);
      }
      _memory.clear();
      _publishSessionState(const Empty());
      await _sessions.close();
      return const AppResult.success(null);
    } catch (error, stackTrace) {
      final failure = _failureForOperation('dispose', error, stackTrace);
      if (!_sessions.isClosed) {
        _publishSessionState(_state.toFailure(failure));
      }
      return AppResult.failure(failure);
    }
  });

  AppResult<String> _sessionIdForOperation() {
    if (_sessions.isClosed) {
      return AppResult.failure(
        AppFailure.repositoryFailure(
          logMessage: 'Session repository is closed',
          stackTrace: StackTrace.current,
        ),
      );
    }
    return switch (_state) {
      Ready(value: final sessionId) ||
      Failure(prev: final sessionId?) => AppResult.success(sessionId),
      Failure(:final failure, prev: null) => AppResult.failure(failure),
      Uninitialized() ||
      Loading() ||
      Updating() ||
      Dirty() ||
      Empty() => AppResult.failure(
        AppFailure.repositoryFailure(
          logMessage:
              'Session identity is not available: ${_state.runtimeType}',
          stackTrace: StackTrace.current,
        ),
      ),
    };
  }

  void _publishSessionState(StatefulData<String, AppFailure> state) {
    _state = state;
    _sessions.add(state);
  }

  Future<AppResult<T>> _inWriteOrder<T>(
    Future<AppResult<T>> Function() operation,
  ) {
    final result = _pendingWrites.then((_) => operation());
    _pendingWrites = result.then<void>((_) {});
    return result;
  }

  AppFailure _failureForOperation(
    String operation,
    Object error,
    StackTrace stackTrace, {
    FatalLevel fatalLevel = FatalLevel.nonFatal,
  }) => AppFailure.repositoryFailure(
    uiMessage: 'Could not complete session operation',
    logMessage: 'AppSessionRepository.$operation failed',
    cause: error,
    stackTrace: stackTrace,
    fatalLevel: fatalLevel,
  );
}
