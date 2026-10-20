import 'package:get_it/get_it.dart';

import '../../shared/core/presentation/services/app_snack_bar.dart';
import '../config/navigation_conf.dart';

void registerPresentationDependencies(GetIt di) {
  di.registerSingleton<AppSnackBar>(AppSnackBar(appNavigatorKey));
}
