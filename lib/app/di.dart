import 'package:get_it/get_it.dart';

import 'di/core_di.dart';
import 'di/features_di.dart';

final di = GetIt.instance;

Future<void> initDI() async {

  registerCoreDependencies(di);

  await di.allReady();

  registerFeatures(di);
}
