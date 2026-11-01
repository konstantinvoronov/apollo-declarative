import 'app_notification_interaction_model.dart';

class AppPushMessageModel {
  final String? messageId;
  final String? title;
  final String? body;
  final Map<String, String> data;
  final AppNotificationInteractionModel? interaction;

  AppPushMessageModel({
    required this.messageId,
    required this.title,
    required this.body,
    required Map<String, String> data,
    required this.interaction,
  }) : data = Map.unmodifiable(data);
}
