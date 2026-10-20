import 'package:package_info_plus/package_info_plus.dart';

import '../domain/services/i_app_build_info_service.dart';

class AppBuildInfoService implements IAppBuildInfoService {
  @override
  final String version;

  @override
  final String buildNumber;

  const AppBuildInfoService._({
    required this.version,
    required this.buildNumber,
  });

  static Future<AppBuildInfoService> load() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return AppBuildInfoService._(
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }
}
