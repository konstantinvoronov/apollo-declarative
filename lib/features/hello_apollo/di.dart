import 'package:get_it/get_it.dart';

import 'presentation/controllers/hello_apollo_controller.dart';

void registerHelloApolloFeature(GetIt di) {
  di.registerFactory<HelloApolloController>(HelloApolloController.new);
}
