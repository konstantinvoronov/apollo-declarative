class AppNotificationModel {
  final int id;
  final String interactionId;
  final String title;
  final String body;
  final String destination;

  const AppNotificationModel({
    required this.id,
    required this.interactionId,
    required this.title,
    required this.body,
    required this.destination,
  });
}
