import 'package:app_failure/app_failure.dart';

abstract interface class IAppLogShareService {
  Future<AppResult<void>> shareLog();
}
