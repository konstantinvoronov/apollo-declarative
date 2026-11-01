enum AppPushRegistrationStatusModel { registered, unregistered }

class AppPushRegistrationModel {
  final String installationId;
  final AppPushRegistrationStatusModel status;

  const AppPushRegistrationModel({
    required this.installationId,
    required this.status,
  });
}
