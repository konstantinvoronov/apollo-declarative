import 'dart:async';

import 'package:app_failure/app_failure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../domain/models/app_notification_interaction_model.dart';
import '../domain/models/app_notification_model.dart';
import '../domain/models/app_notification_permission_model.dart';
import '../domain/services/i_app_local_notification_service.dart';
import '../domain/services/i_app_logger_service.dart';
import 'mappers/app_notification_service_mapper.dart';

class AppLocalNotificationService implements IAppLocalNotificationService {
  final IAppLoggerService _logger;
  final FlutterLocalNotificationsPlugin _plugin;
  final _interactions =
      StreamController<AppResult<AppNotificationInteractionModel>>.broadcast();
  final _mapper = const AppNotificationServiceMapper();
  Future<AppResult<void>>? _initialization;
  bool _launchInteractionConsumed = false;

  AppLocalNotificationService(this._logger)
    : _plugin = FlutterLocalNotificationsPlugin();

  @override
  bool get isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  @override
  Stream<AppResult<AppNotificationInteractionModel>> get interactions =>
      _interactions.stream;

  @override
  Future<AppResult<void>> initialize() =>
      _initialization ??= _initializePlugin();

  Future<AppResult<void>> _initializePlugin() async {
    if (!isSupported) return const AppResult.success(null);
    try {
      final initialized = await _plugin.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('ic_notification'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          ),
        ),
        onDidReceiveNotificationResponse: _publishInteraction,
      );
      if (initialized != true) {
        throw StateError('Local notification initialization failed');
      }
      await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(notificationChannel);
      unawaited(
        _logger.log('notifications.local.initialized', 'notifications'),
      );
      return const AppResult.success(null);
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Local notification initialization failed',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  static const notificationChannel = AndroidNotificationChannel(
    'apollo_notifications',
    'Apollo notifications',
    description: 'Notifications from Apollo',
    importance: Importance.high,
  );

  void _publishInteraction(NotificationResponse response) {
    if (_interactions.isClosed) return;
    try {
      final interaction = _mapper.interactionForPayload(response.payload);
      _interactions.add(AppResult.success(interaction));
      unawaited(
        _logger.log('notifications.local.interaction', 'notifications'),
      );
    } catch (error, stackTrace) {
      _interactions.add(
        AppResult.failure(
          AppFailure.unhandledFailure(
            logMessage: 'Local notification interaction rejected',
            error: error,
            stackTrace: stackTrace,
          ),
        ),
      );
    }
  }

  @override
  Future<AppResult<AppNotificationPermissionModel>> requestPermission() async {
    if (!isSupported) {
      return const AppResult.success(
        AppNotificationPermissionModel.unavailable,
      );
    }
    try {
      (await initialize()).fold((_) {}, (failure) => throw failure);
      if (defaultTargetPlatform == TargetPlatform.android) {
        await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()!
            .requestNotificationsPermission();
      } else {
        await _plugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()!
            .requestPermissions(alert: true, badge: true, sound: true);
      }
      final permission = (await readPermission()).fold(
        (value) => value,
        (failure) => throw failure,
      );
      unawaited(
        _logger.log(
          'notifications.permission.${permission.name}',
          'notifications',
        ),
      );
      return AppResult.success(permission);
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Notification permission request failed',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<AppResult<AppNotificationPermissionModel>> readPermission() async {
    if (!isSupported) {
      return const AppResult.success(
        AppNotificationPermissionModel.unavailable,
      );
    }
    try {
      (await initialize()).fold((_) {}, (failure) => throw failure);
      if (defaultTargetPlatform == TargetPlatform.android) {
        final enabled = await _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()!
            .areNotificationsEnabled();
        if (enabled == null) {
          throw StateError('Notification permission unavailable');
        }
        return AppResult.success(
          enabled
              ? AppNotificationPermissionModel.authorized
              : AppNotificationPermissionModel.denied,
        );
      }
      final options = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()!
          .checkPermissions();
      if (options == null) {
        throw StateError('Notification permission unavailable');
      }
      return AppResult.success(
        options.isProvisionalEnabled
            ? AppNotificationPermissionModel.provisional
            : options.isEnabled
            ? AppNotificationPermissionModel.authorized
            : AppNotificationPermissionModel.denied,
      );
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Notification permission read failed',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> displayNotification(
    AppNotificationModel notification,
  ) async {
    try {
      final permission = (await readPermission()).fold(
        (value) => value,
        (failure) => throw failure,
      );
      if (permission != AppNotificationPermissionModel.authorized &&
          permission != AppNotificationPermissionModel.provisional) {
        throw AppFailure.permissionFailure(
          'Enable notifications in system settings.',
        );
      }
      await _plugin.show(
        id: notification.id,
        title: notification.title,
        body: notification.body,
        payload: _mapper.payloadForNotification(notification),
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'apollo_notifications',
            'Apollo notifications',
            channelDescription: 'Notifications from Apollo',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentSound: true,
            presentBadge: false,
          ),
        ),
      );
      unawaited(
        _logger.log('notifications.local.display.requested', 'notifications'),
      );
      return const AppResult.success(null);
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Local notification display failed',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<AppResult<void>> cancelNotification(int id) async {
    try {
      if (!isSupported) {
        throw UnsupportedError('Notifications require iOS or Android');
      }
      (await initialize()).fold((_) {}, (failure) => throw failure);
      await _plugin.cancel(id: id);
      unawaited(_logger.log('notifications.local.cancelled', 'notifications'));
      return const AppResult.success(null);
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Local notification cancellation failed',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<AppResult<AppNotificationInteractionModel?>>
  consumeLaunchInteraction() async {
    if (!isSupported || _launchInteractionConsumed) {
      return const AppResult.success(null);
    }
    try {
      (await initialize()).fold((_) {}, (failure) => throw failure);
      final details = await _plugin.getNotificationAppLaunchDetails();
      _launchInteractionConsumed = true;
      if (details?.didNotificationLaunchApp != true) {
        return const AppResult.success(null);
      }
      return AppResult.success(
        _mapper.interactionForPayload(details!.notificationResponse?.payload),
      );
    } catch (error, stackTrace) {
      return AppResult.failure(
        AppFailure.unhandledFailure(
          logMessage: 'Local notification launch interaction rejected',
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }

  @override
  Future<void> dispose() => _interactions.close();
}
