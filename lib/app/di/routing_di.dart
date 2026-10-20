import 'package:get_it/get_it.dart';

import '../routing/app_router.dart';

void registerRoutingDependencies(GetIt di) {
  di.registerSingleton<AppRouter>(
    AppRouter(),
    dispose: (router) => router.dispose(),
  );
}
