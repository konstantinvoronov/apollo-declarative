import 'package:app_failure/app_failure.dart';
import 'package:stateful_data/stateful_data.dart';

import '../params/app_session_params.dart';

abstract interface class IAppSessionRepository {
  StatefulData<String, AppFailure> get state;

  /// Broadcast changes; read state for the current snapshot, including after startup.
  Stream<StatefulData<String, AppFailure>> get sessions;

  /// Restore or create the session; repeated initialization retains the active session.
  Future<AppResult<String>> initialize();

  /// Global sessionId is reserved; persistent writes invalidate cache so reads use storage-normalized values.
  Future<AppResult<bool>> set<T>(AppSessionParams<T> params, T value);

  /// Returns failure for unavailable data, an in-progress write to this key, or disposal.
  AppResult<T> get<T>(AppSessionParams<T> params);

  /// Clear old session data before committing a new ID; persistence is not transactional.
  Future<AppResult<String>> renewSession();

  /// Delete current session-scoped storage, then close; global settings remain.
  Future<AppResult<void>> dispose();
}
