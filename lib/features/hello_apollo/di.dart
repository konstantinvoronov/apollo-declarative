import 'package:get_it/get_it.dart';

import '../../core/domain/services/i_app_build_info_service.dart';
import 'presentation/controllers/bottom_sheet_example_cubit.dart';
import 'presentation/controllers/hello_apollo_cubit.dart';

void registerHelloApolloFeature(GetIt di) {
  di.registerFactory<BottomSheetExampleCubit>(() => BottomSheetExampleCubit());
  di.registerFactory<HelloApolloCubit>(
    () => HelloApolloCubit(di<IAppBuildInfoService>()),
  );
}
