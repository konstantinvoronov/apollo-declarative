import 'dart:convert';

import '../../domain/models/app_notification_interaction_model.dart';
import '../../domain/models/app_notification_model.dart';

class AppNotificationServiceMapper {
  const AppNotificationServiceMapper();

  String payloadForNotification(AppNotificationModel notification) =>
      jsonEncode({
        'version': '1',
        'notification_id': notification.interactionId,
        'destination': notification.destination,
      });

  AppNotificationInteractionModel interactionForPayload(String? payload) {
    if (payload == null) {
      throw const FormatException('Missing notification payload');
    }
    final data = jsonDecode(payload);
    if (data is! Map<String, dynamic>) {
      throw const FormatException('Notification payload must be an object');
    }
    return interactionForData(data);
  }

  AppNotificationInteractionModel interactionForData(
    Map<String, dynamic> data,
  ) {
    final id = data['notification_id'];
    final destination = data['destination'];
    if (data['version'] != '1' ||
        id is! String ||
        id.isEmpty ||
        destination is! String ||
        destination.isEmpty) {
      throw const FormatException('Invalid notification interaction contract');
    }
    return AppNotificationInteractionModel(
      notificationId: id,
      destination: destination,
    );
  }
}
