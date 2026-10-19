import 'package:ai_declarative_foldering_architecture/app/di/di.dart';
import 'package:ai_declarative_foldering_architecture/app/routing/app_router.dart';
import 'package:ai_declarative_foldering_architecture/core/services/shake_service.dart';
import 'package:ai_declarative_foldering_architecture/core/telemetry/app_logger.dart';
import 'package:ai_declarative_foldering_architecture/libs/app_uikit/shared/presentation/services/app_toast.dart';
import 'package:app_failure/app_failure.dart';
import 'package:flutter/material.dart';

class AppGlobalErrorHandlers {
  static Future<void> handleZonedError(Object error, StackTrace   stack) async {
    final logger = di<AppLogger>();
    final shakeService = di<ShakeService>();
    final snackbar = di<AppSnackBar>();

    if (error is AppFailure) {
      print(error.toString());

      if (error.fatalLevel == FatalLevel.featureFatal) {
        di<AppRouter>().router.push('/');
      }
      if (error.fatalLevel == FatalLevel.appFatal) {
        di<AppRouter>().router.push('/');
        WidgetsBinding.instance.reassembleApplication();
      }

      await AppLogger().logFailure(error);


      // TODO здень надо убедится что повторящиеся ошибки не будут вылетать.


      // некоторые ошибки которые сюда доходят должны быть показаны

      if((error.showReportBugDialog ?? false)){
        final context = di<AppRouter>().rootNavigatorKey;
        if(context==null) return;

        // await locator<Navigation>().open(context, AppDialogs.reportBug, AppReportBugParams(appFailure:error));
      }else {
        if(error.fatalLevel!=FatalLevel.silent){
          snackbar.error(error.uiMessage ?? 'Some error happened. Please report log to developers.');
        }
      }

    } else {
      final failure = AppFailure.unhandledFailure(uiMessage:'Some unhandled error happened.',error: error, stackTrace: stack);

      print(failure.toString());

      // некоторые ошибки которые сюда доходят должны быть показаны некоторые репортнуты
      await AppLogger().logFailure(failure);

      final context = di<AppRouter>().rootNavigatorKey;
      if(context==null) return;

      // ShakeService.instance.desabled = bugReportWindow is already on
      // FIXME add error pattern filter. do not show bugreportDialog for just any failure
      if (timeToSuggestReport(failure) && shakeService.enabled) {
        shakeService.disable();
        // await locator<Navigation>().open(context, AppDialogs.reportBug, AppReportBugParams(appFailure: failure,));
      }
    }
  }

  static bool timeToSuggestReport(failure) {
    // analize error patterns and frequency here to decide wheater its time to suggest bug report
    return false;
  }
}
