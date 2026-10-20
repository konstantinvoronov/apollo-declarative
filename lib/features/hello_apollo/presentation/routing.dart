import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../libs/uikit/core/presentation/models/modal_sheet_config.dart';
import '../../../libs/uikit/core/presentation/wrappers/modal_sheet_page_wrapper.dart';
import '../../../libs/uikit/core/presentation/sheets/alternative_modal_sheet_page.dart';
import 'controllers/bottom_sheet_example_cubit.dart';
import 'controllers/hello_apollo_cubit.dart';
import 'models/bottom_sheet_example_params.dart';
import 'screens/hello_apollo_screen.dart';
import 'sheets/bottom_sheet_example_sheet.dart';

List<RouteBase> buildHelloApolloRoutes(GetIt di) {
  return [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          HelloApolloScreen(createCubit: () => di<HelloApolloCubit>()),
    ),
    GoRoute(
      path: '/hello-apollo/legacy-sheet',
      pageBuilder: (context, state) => ModalSheetPageWrapper<bool>(
        ModalSheetConfig(
          child: BottomSheetExampleSheet(
            createCubit: () => di<BottomSheetExampleCubit>(),
            params: (state.extra as BottomSheetExampleParams?) ??
                const BottomSheetExampleParams(),
          ),
        ),
        key: state.pageKey,
      ),
    ),
    GoRoute(
      path: '/hello-apollo/alternative-sheet',
      pageBuilder: (context, state) => AlternativeModalSheetPage<bool>(
        key: state.pageKey,
        child: BottomSheetExampleSheet(
          createCubit: () => di<BottomSheetExampleCubit>(),
          params: (state.extra as BottomSheetExampleParams?) ??
              const BottomSheetExampleParams(),
        ),
      ),
    ),
  ];
}
