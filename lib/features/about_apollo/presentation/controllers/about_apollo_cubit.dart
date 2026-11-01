import 'dart:async';
import 'package:app_failure/app_failure.dart';
import '../../../../core/domain/models/app_notification_model.dart';
import '../../../../core/domain/models/app_notification_permission_model.dart';
import '../../../../core/domain/models/app_push_message_model.dart';
import '../../../../core/domain/services/i_app_local_notification_service.dart';
import '../../../../core/domain/services/i_app_push_notification_service.dart';
import '../../../../core/domain/models/app_push_registration_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/domain/services/i_app_build_info_service.dart';
import '../../../../core/domain/services/i_app_log_share_service.dart';

part 'about_apollo_state.dart';

class AboutApolloCubit extends Cubit<AboutApolloState> {
  final IAppLogShareService _logShareService;

  final IAppLocalNotificationService _notifications;
  final IAppPushNotificationService _push;
  StreamSubscription<AppResult<AppPushMessageModel>>? _foregroundMessages;
  StreamSubscription<AppResult<AppPushRegistrationModel>>? _registrationEvents;
  final _displayedPushIds = <String>{};
  static const exampleNotificationId = 1001;

  bool get supportsNotifications => _notifications.isSupported;
  bool get supportsPush => _push.isEnabled;

  AboutApolloCubit(
    IAppBuildInfoService buildInfo,
    this._logShareService,
    this._notifications,
    this._push,
  ) : super(
        AboutApolloState.initial(
          version: buildInfo.version,
          buildNumber: buildInfo.buildNumber,
        ),
      ) {
    _foregroundMessages = _push.foregroundMessages.listen((result) {
      result.fold(
        (message) => unawaited(_displayForegroundPush(message)),
        _recordNotificationFailure,
      );
    });
    _registrationEvents = _push.registrations.listen((result) {
      if (isClosed) return;
      result.fold(
        (registration) => emit(state.copyWith(pushRegistration: registration)),
        _recordNotificationFailure,
      );
    });
  }

  Future<void> requestNotificationPermission() async {
    if (state.notificationStatus == AboutApolloNotificationStatus.busy) return;
    emit(
      state.copyWith(notificationStatus: AboutApolloNotificationStatus.busy),
    );
    final result = await _notifications.requestPermission();
    if (isClosed) return;
    result.fold(
      (permission) => emit(
        state.copyWith(
          notificationPermission: permission,
          notificationStatus: AboutApolloNotificationStatus.idle,
        ),
      ),
      _recordNotificationActionFailure,
    );
  }

  Future<void> displayExampleNotification({
    required String title,
    required String body,
  }) async {
    if (state.notificationStatus == AboutApolloNotificationStatus.busy) return;
    emit(
      state.copyWith(notificationStatus: AboutApolloNotificationStatus.busy),
    );
    final result = await _notifications.displayNotification(
      AppNotificationModel(
        id: exampleNotificationId,
        interactionId: 'example-${DateTime.now().microsecondsSinceEpoch}',
        title: title,
        body: body,
        destination: 'home',
      ),
    );
    if (isClosed) return;
    result.fold(
      (_) => emit(
        state.copyWith(notificationStatus: AboutApolloNotificationStatus.idle),
      ),
      _recordNotificationActionFailure,
    );
  }

  Future<void> cancelExampleNotification() async {
    if (state.notificationStatus == AboutApolloNotificationStatus.busy) return;
    emit(
      state.copyWith(notificationStatus: AboutApolloNotificationStatus.busy),
    );
    final result = await _notifications.cancelNotification(
      exampleNotificationId,
    );
    if (isClosed) return;
    result.fold(
      (_) => emit(
        state.copyWith(notificationStatus: AboutApolloNotificationStatus.idle),
      ),
      _recordNotificationActionFailure,
    );
  }

  Future<void> registerForPush() async {
    if (state.notificationStatus == AboutApolloNotificationStatus.busy) return;
    emit(
      state.copyWith(notificationStatus: AboutApolloNotificationStatus.busy),
    );
    final result = await _push.registerDevice();
    if (isClosed) return;
    result.fold(
      (_) => emit(
        state.copyWith(notificationStatus: AboutApolloNotificationStatus.idle),
      ),
      _recordNotificationActionFailure,
    );
  }

  Future<void> _displayForegroundPush(AppPushMessageModel message) async {
    if (isClosed || (message.title == null && message.body == null)) return;
    final id = message.messageId;
    if (id != null && !_displayedPushIds.add(id)) return;
    if (_displayedPushIds.length > 128) {
      _displayedPushIds.remove(_displayedPushIds.first);
    }
    final result = await _notifications.displayNotification(
      AppNotificationModel(
        id:
            (id ?? DateTime.now().microsecondsSinceEpoch.toString()).hashCode &
            0x7fffffff,
        interactionId:
            message.interaction?.notificationId ??
            id ??
            DateTime.now().microsecondsSinceEpoch.toString(),
        title: message.title ?? '',
        body: message.body ?? '',
        destination: message.interaction?.destination ?? 'home',
      ),
    );
    result.fold((_) {}, (failure) {
      if (id != null) _displayedPushIds.remove(id);
      _recordNotificationFailure(failure);
    });
  }

  void _recordNotificationActionFailure(AppFailure failure) {
    if (isClosed) return;
    emit(
      state.copyWith(notificationStatus: AboutApolloNotificationStatus.idle),
    );
    _recordNotificationFailure(failure);
  }

  void _recordNotificationFailure(AppFailure failure) {
    if (isClosed) return;
    final contextualFailure = AppFailure.controllerFailure(
      logMessage: 'About Apollo notification action failed',
      cause: failure,
      stackTrace: StackTrace.current,
    );
    emit(
      state.copyWith(
        errors: {
          ...state.errors,
          AboutApolloErrorType.unhandledError: contextualFailure,
        },
      ),
    );
  }

  @override
  Future<void> close() async {
    await _foregroundMessages?.cancel();
    await _registrationEvents?.cancel();
    await super.close();
  }

  Future<void> onVersionTap() async {
    if (state.logShareStatus == AboutApolloLogShareStatus.sharing) return;
    final tapCount = state.versionTapCount + 1;
    if (tapCount < 10) {
      emit(state.copyWith(versionTapCount: tapCount));
      return;
    }
    emit(
      state.copyWith(
        versionTapCount: 0,
        logShareStatus: AboutApolloLogShareStatus.sharing,
      ),
    );
    try {
      (await _logShareService.shareLog()).fold(
        (_) {},
        (failure) => throw failure,
      );
      if (isClosed) return;
      emit(state.copyWith(logShareStatus: AboutApolloLogShareStatus.idle));
    } catch (error, stackTrace) {
      if (isClosed) return;
      emit(
        state.copyWith(
          logShareStatus: AboutApolloLogShareStatus.idle,
          errors: {
            ...state.errors,
            AboutApolloErrorType.unhandledError: AppFailure.controllerFailure(
              logMessage: 'About Apollo version-tap log sharing failed',
              cause: error,
              stackTrace: stackTrace,
            ),
          },
        ),
      );
    }
  }

  void clearUnhandledError(AboutApolloErrorType? err) {
    emit(
      state.copyWith(
        errors: {...state.errors}
          ..remove(err ?? AboutApolloErrorType.unhandledError),
      ),
    );
  }

  void recordSheetResult(bool? result) {
    emit(
      state.copyWith(
        sheetResult: result == true
            ? AboutApolloSheetResult.confirmed
            : AboutApolloSheetResult.cancelled,
      ),
    );
  }
}
