import 'package:app_failure/app_failure.dart';

import '../models/app_notification_interaction_model.dart';
import '../models/app_notification_model.dart';
import '../models/app_notification_permission_model.dart';

abstract interface class IAppLocalNotificationService {
  bool get isSupported;
  Stream<AppResult<AppNotificationInteractionModel>> get interactions;
  Future<AppResult<void>> initialize();
  Future<AppResult<AppNotificationPermissionModel>> requestPermission();
  Future<AppResult<AppNotificationPermissionModel>> readPermission();
  Future<AppResult<void>> displayNotification(
    AppNotificationModel notification,
  );
  Future<AppResult<void>> cancelNotification(int id);
  Future<AppResult<AppNotificationInteractionModel?>>
  consumeLaunchInteraction();
  Future<void> dispose();
}
