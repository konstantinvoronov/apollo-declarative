import 'dart:async';
import 'dart:developer' as developer;

import 'package:app_failure/app_failure.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../domain/models/app_notification_interaction_model.dart';
import '../domain/models/app_push_message_model.dart';
import '../domain/models/app_push_registration_model.dart';
import '../domain/services/i_app_logger_service.dart';
import '../domain/services/i_app_push_notification_service.dart';
import 'mappers/app_notification_service_mapper.dart';

@pragma('vm:entry-point')
Future<void> receiveAppBackgroundPush(RemoteMessage message) async {
  try {
    await Firebase.initializeApp();
    developer.log(
      'notifications.push.background.received',
      name: 'notifications',
    );
  } catch (error, stackTrace) {
    final failure = AppFailure.unhandledFailure(
      logMessage: 'notifications.push.background.failed',
      error: error,
      stackTrace: stackTrace,
    );
    developer.log(
      failure.toString(),
      name: 'notifications',
      stackTrace: stackTrace,
    );
  }
}

class AppPushNotificationService implements IAppPushNotificationService {
  final IAppLoggerService _logger;
  final bool _enabled;
  final _messages =
      StreamController<AppResult<AppPushMessageModel>>.broadcast();
  final _interactions =
      StreamController<AppResult<AppNotificationInteractionModel>>.broadcast();
  final _registrations =
      StreamController<AppResult<AppPushRegistrationModel>>.broadcast();
  final _subscriptions = <StreamSubscription<dynamic>>[];
  final _mapper = const AppNotificationServiceMapper();
  FirebaseMessaging? _messaging;
  Future<AppResult<void>>? _initialization;

  AppPushNotificationService(this._logger, {required bool enabled})
    : _enabled = enabled;

  @override
  bool get isEnabled =>
      _enabled &&
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  @override
  Stream<AppResult<AppPushMessageModel>> get foregroundMessages =>
      _messages.stream;
  @override
  Stream<AppResult<AppNotificationInteractionModel>> get interactions =>
      _interactions.stream;
  @override
  Stream<AppResult<AppPushRegistrationModel>> get registrations =>
      _registrations.stream;

  @override
  Future<AppResult<void>> initialize() =>
      _initialization ??= _initializeMessaging();

  Future<AppResult<void>> _initializeMessaging() async {
    if (!isEnabled) {
      unawaited(_logger.log('notifications.push.disabled', 'notifications'));
      return const AppResult.success(null);
    }
    try {
      await Firebase.initializeApp();
      final messaging = FirebaseMessaging.instance;
      FirebaseMessaging.onBackgroundMessage(receiveAppBackgroundPush);
      await messaging.setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false,
      );
      _subscriptions.add(
        FirebaseMessaging.onMessage.listen(
          _publishMessage,
          onError: (Object error, StackTrace stack) {
            _messages.add(
              AppResult.failure(
                AppFailure.unhandledFailure(
                  logMessage: 'Foreground push reception failed',
                  error: error,
                  stackTrace: stack,
                ),
              ),
            );
          },
        ),
      );
      _subscriptions.add(
        FirebaseMessaging.onMessageOpenedApp.listen(
          _publishInteraction,
          onError: (Object error, StackTrace stack) {
            _interactions.add(
              AppResult.failure(
                AppFailure.unhandledFailure(
                  logMessage: 'Push interaction failed',
                  error: error,
                  stackTrace: stack,
                ),
              ),
            );
          },
        ),
      );
      _subscriptions.add(
        messaging.onRegistered.listen(
          (id) => _publishRegistration(
            id,
            AppPushRegistrationStatusModel.registered,
          ),
          onError: _publishRegistrationFailure,
        ),
      );
      _subscriptions.add(
        messaging.onUnregistered.listen(
          (id) => _publishRegistration(
            id,
            AppPushRegistrationStatusModel.unregistered,
          ),
          onError: _publishRegistrationFailure,
        ),
      );
      _messaging = messaging;
      unawaited(_logger.log('notifications.push.initialized', 'notifications'));
      return const AppResult.success(null);
    } catch (error, stackTrace) {
      for (final subscription in _subscriptions) {
        await subscription.cancel();
      }
      _subscriptions.clear();
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage:
              'Firebase push initialization failed; verify native app configuration',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  void _publishMessage(RemoteMessage message) {
    try {
      _messages.add(
        AppResult.success(
          AppPushMessageModel(
            messageId: message.messageId,
            title: message.notification?.title,
            body: message.notification?.body,
            data: message.data.cast<String, String>(),
            interaction: message.data.isEmpty
                ? null
                : _mapper.interactionForData(message.data),
          ),
        ),
      );
      unawaited(
        _logger.log('notifications.push.foreground.received', 'notifications'),
      );
    } catch (error, stackTrace) {
      _messages.add(
        AppResult.failure(
          AppFailure.unhandledFailure(
            logMessage: 'Push message conversion failed',
            error: error,
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  void _publishInteraction(RemoteMessage message) {
    try {
      _interactions.add(
        AppResult.success(_mapper.interactionForData(message.data)),
      );
      unawaited(_logger.log('notifications.push.interaction', 'notifications'));
    } catch (error, stackTrace) {
      _interactions.add(
        AppResult.failure(
          AppFailure.unhandledFailure(
            logMessage: 'Push interaction payload rejected',
            error: error,
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  void _publishRegistration(String id, AppPushRegistrationStatusModel status) {
    _registrations.add(
      AppResult.success(
        AppPushRegistrationModel(installationId: id, status: status),
      ),
    );
    unawaited(
      _logger.log('notifications.push.${status.name}', 'notifications'),
    );
  }

  void _publishRegistrationFailure(Object error, StackTrace stackTrace) {
    _registrations.add(
      AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Push registration event failed',
          error: error,
          stackTrace: stackTrace,
        ),
      ),
    );
  }

  @override
  Future<AppResult<void>> registerDevice() async {
    try {
      if (!isEnabled) {
        throw StateError('Firebase push is disabled for this build');
      }
      (await initialize()).fold((_) {}, (failure) => throw failure);
      final settings = await _messaging!.getNotificationSettings();
      if (settings.authorizationStatus != AuthorizationStatus.authorized &&
          settings.authorizationStatus != AuthorizationStatus.provisional) {
        throw AppFailure.permissionFailure(
          'Enable notifications before registering for push.',
        );
      }
      await _messaging!.setAutoInitEnabled(true);
      await _messaging!.register();
      unawaited(
        _logger.log(
          'notifications.push.registration.requested',
          'notifications',
        ),
      );
      return const AppResult.success(null);
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Push device registration failed',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> unregisterDevice() async {
    try {
      if (!isEnabled) {
        throw StateError('Firebase push is disabled for this build');
      }
      (await initialize()).fold((_) {}, (failure) => throw failure);
      await _messaging!.setAutoInitEnabled(false);
      await _messaging!.unregister();
      return const AppResult.success(null);
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Push device unregistration failed',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<AppResult<AppNotificationInteractionModel?>>
  consumeLaunchInteraction() async {
    if (!isEnabled) return const AppResult.success(null);
    try {
      (await initialize()).fold((_) {}, (failure) => throw failure);
      final message = await _messaging!.getInitialMessage();
      return AppResult.success(
        message == null ? null : _mapper.interactionForData(message.data),
      );
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Push launch interaction rejected',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<void> dispose() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _messages.close();
    await _interactions.close();
    await _registrations.close();
  }
}
