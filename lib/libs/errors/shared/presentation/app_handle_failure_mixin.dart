import 'package:footunion/app/di/di.dart';
import 'package:footunion/core/telemetry/app_logger.dart';
import 'package:footunion/libs/app_uikit/shared/presentation/services/app_toast.dart';
import 'package:app_failure/app_failure.dart';
import 'package:footunion/shared/extensions/tr_extension.dart';
import 'package:flutter/material.dart';


/// A mixin for handling `AppFailure` instances in the UI layer.
///
/// This mixin provides a unified mechanism for reacting to different types of
/// failures within controllers or Cubits, typically inside a `BlocListener`.
///
/// The main method, [uiFailureHandler], is used to:
/// - Display user-friendly messages via toast
/// - Log failures using [AppLogger]
/// - Optionally execute fallback actions (e.g., pop a screen)
/// - Throw fatal app-level failures
/// - Clear the handled error from state
///
/// Typical usage in a controller:
/// ```dart
/// if (state.errors.containsKey(P2eErrorType.unhandledError)) {
///   uiFailureHandler(
///     context: context,
///     failure: state.errors[P2eErrorType.unhandledError]!,
///     clearUnhandledError: cubit.clearUnhandledError,
///     fallback: () => locator<Navigation>().pop(),
///   );
/// }
/// ```
mixin AppHandleFailure{

  /// uiFailureHandler (was HandleFailure) Handles an [AppFailure] by:
  ///
  /// - Logging the failure with [AppLogger]
  /// - Displaying a user-friendly message using `failure.uiMessage` or a fallback message
  /// - Executing [fallback] if the failure is feature-fatal
  /// - Throwing the exception if the failure is app-fatal
  /// - Calling [clearUnhandledError] if the failure is recoverable
  ///
  /// Used in Bloc listeners to ensure consistent UI-level error handling
  uiFailureHandler(
      {required BuildContext context,
        Function()? fallback,
        required AppFailure failure,
        required Function() clearUnhandledError}) {

    final logger = di<AppLogger>();
    final snackbar = di<AppSnackBar>();

    logger.logFailure(failure, context: 'HandleFailure: logger',);

    switch(failure){

      case ValidationFailure():
        snackbar.error((failure.uiMessage ?? 'Validation failed.').trEx(context));
      case HttpFailure():
        snackbar.error((failure.uiMessage?.trEx(context) ?? 'Network Error.').trEx(context));
      case ApiFailure():
        snackbar.error((failure.uiMessage?.trEx(context) ?? 'We could not parse some date.').trEx(context));
      case PerformanceFailure():
        snackbar.error(failure.uiMessage ?? 'It takes longer.'.trEx(context));
      case PermissionFailure():
        snackbar.error(failure.uiMessage ?? 'Not enough permission.'.trEx(context));
      case ControllerFailure():
        snackbar.error((failure.uiMessage ?? 'Some errors happened during operation.').trEx(context));
      case UnhandledFailure():
        snackbar.error((failure.uiMessage ?? 'We are experiencing some troubles.').trEx(context));
      case RepositoryFailure():
        snackbar.error((failure.uiMessage ?? 'We are experiencing some troubles.').trEx(context));
    }

    clearUnhandledError.call();

    if (failure.fatalLevel == FatalLevel.featureFatal) {
      // TODO suggest upload bug report logic
      fallback?.call();
      return;
    }
    if (failure.fatalLevel == FatalLevel.appFatal) {
      throw (Exception(failure));
    }
  }

}

