import 'domain/services/i_app_build_info_service.dart';
import 'services/app_build_info_service.dart';
import 'domain/services/i_app_log_share_service.dart';
import 'services/app_log_share_service.dart';
import 'domain/services/i_shake_service.dart';
import 'services/shake_service.dart';
import 'domain/services/i_app_logger_service.dart';
import 'services/app_logger_service.dart';
import 'domain/services/i_app_haptic_service.dart';
import 'services/app_haptic_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'domain/repositories/i_app_session_repository.dart';
import 'infrastructure/repositories/app_session_repository.dart';
import 'domain/repositories/i_app_settings_repository.dart';
import 'infrastructure/repositories/app_settings_repository.dart';

void registerCore(GetIt di) {
  di.registerSingletonAsync<IAppBuildInfoService>(AppBuildInfoService.load);
  di.registerSingleton<IAppLoggerService>(AppLoggerService());
  di.registerLazySingleton<IAppLogShareService>(() => AppLogShareService(
    di<IAppLoggerService>(),
    archivePassword: const String.fromEnvironment(
      'APOLLO_LOG_ARCHIVE_PASSWORD',
      defaultValue: 'ApolloSupport2026',
    ),
  ));
  di.registerLazySingleton<IAppHapticService>(() => AppHapticService());
  di.registerLazySingleton<IShakeService>(() => ShakeService());

  di.registerSingletonAsync<SharedPreferences>(() async {
    return await SharedPreferences.getInstance();
  });

  di.registerSingletonWithDependencies<IAppSettingsRepository>(
    () => AppSettingsRepository(di<SharedPreferences>()),
    dependsOn: [SharedPreferences],
  );

  di.registerSingletonAsync<IAppSessionRepository>(() async {
    final repo = AppSessionRepository(di<IAppSettingsRepository>());
    return (await repo.initialize()).fold(
      (_) => repo,
      (failure) => throw failure,
    );
  }, dependsOn: [IAppSettingsRepository], dispose: (repo) async {
    (await repo.dispose()).fold((_) {}, (failure) => throw failure);
  });
}
