import 'dart:async';

import 'package:app_failure/app_failure.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app/app.dart';
import 'app/di.dart';
import 'core/services/app_logger_service.dart';

Future<void> main() async {
  AppLoggerService? initializedLogger;

  runZonedGuarded(() async {
    final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    final AppLoggerService logger = AppLoggerService();
    await logger.init();
    initializedLogger = logger;

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.dumpErrorToConsole(details);
      final AppFailure failure = AppFailure.unhandledFailure(error: details.exception, stackTrace: details.stack ?? StackTrace.current);
      logger.logFailure(failure);
    };

    await EasyLocalization.ensureInitialized();
    await initDI();


    // FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);



    FlutterNativeSplash.remove();

    runApp(EasyLocalization(
        supportedLocales: [Locale('en', 'US'), ],
        useOnlyLangCode: true,
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'US'),
        child:const AppWidget()));
  }, (Object error, StackTrace stackTrace) {
    final AppLoggerService? logger = initializedLogger;
    if (logger == null) {
      FlutterError.dumpErrorToConsole(FlutterErrorDetails(exception: error, stack: stackTrace));
      return;
    }
    final AppFailure failure = error is AppFailure
        ? error
        : AppFailure.unhandledFailure(error: error, stackTrace: stackTrace);
    logger.logFailure(failure);
  });
}
