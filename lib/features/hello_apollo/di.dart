import 'package:get_it/get_it.dart';

import 'presentation/controllers/hello_apollo_cubit.dart';

void registerHelloApolloFeature(GetIt di) {
  di.registerFactory<HelloApolloCubit>(HelloApolloCubit.new);
}
