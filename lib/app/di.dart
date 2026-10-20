import 'package:get_it/get_it.dart';

import 'di/core_di.dart';
import 'di/features_di.dart';
import 'di/presentation_di.dart';
import 'di/routing_di.dart';

final di = GetIt.instance;

Future<void> initDI() async {
  registerPresentationDependencies(di);
  registerCoreDependencies(di);

  await di.allReady();

  registerFeatures(di);
  registerRoutingDependencies(di);
}
