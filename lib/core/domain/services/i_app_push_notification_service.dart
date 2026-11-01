import 'package:app_failure/app_failure.dart';

import '../models/app_notification_interaction_model.dart';
import '../models/app_push_message_model.dart';
import '../models/app_push_registration_model.dart';

abstract interface class IAppPushNotificationService {
  bool get isEnabled;
  Stream<AppResult<AppPushMessageModel>> get foregroundMessages;
  Stream<AppResult<AppNotificationInteractionModel>> get interactions;
  Stream<AppResult<AppPushRegistrationModel>> get registrations;
  Future<AppResult<void>> initialize();
  Future<AppResult<void>> registerDevice();
  Future<AppResult<void>> unregisterDevice();
  Future<AppResult<AppNotificationInteractionModel?>>
  consumeLaunchInteraction();
  Future<void> dispose();
}
