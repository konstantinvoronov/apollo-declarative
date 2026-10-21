import 'package:get_it/get_it.dart';

import '../../core/domain/services/i_app_build_info_service.dart';
import '../../core/domain/services/i_app_log_share_service.dart';
import 'presentation/controllers/bottom_sheet_example_cubit.dart';
import 'presentation/controllers/about_apollo_cubit.dart';

void registerAboutApolloFeature(GetIt di) {
  di.registerFactory<BottomSheetExampleCubit>(() => BottomSheetExampleCubit());
  di.registerFactory<AboutApolloCubit>(
    () => AboutApolloCubit(di<IAppBuildInfoService>(), di<IAppLogShareService>()),
  );
}
