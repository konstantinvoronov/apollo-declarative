

/* Examaples
// bottom sheet routing togethat with AppModalSheet AppUiKit
            GoRoute(
              path: 'addkids',
              pageBuilder: (context, state) =>
                  ModalSheetPage(
                    ModalSheetConfig(
                      child:
                      AddAKidScreen(
                          params: AddAKidScreenParams(
                              kid: (state.extra is Kid?)
                                  ? state.extra as Kid?
                                  : null)),
                      shrinkWrap: true,
                    ),
                  ),
// multiple params
            GoRoute(
                path: '/page/edit_schedule/:;pageid/:subpageid',
                builder: (context, state) =>
                    CreateOrEditScheduleItemPage(
                        pageId: state.pathParameters['pageid']!, scheduleItemId: null,
                        subPageId: state.pathParameters['subpageid']!, onTap: () {})),

 */
import 'package:flutter/services.dart';
import 'package:ai_declarative_foldering_architecture/app/app_shell.dart';
import 'package:ai_declarative_foldering_architecture/app/routing/observers.dart';
import '../../core/services/app_logger_service.dart';
import 'package:ai_declarative_foldering_architecture/features/game_play/presentation/game_play_routes.dart';
import 'package:ai_declarative_foldering_architecture/features/wallet/presentation/screens/game_limit_hit_sheet.dart';
import 'package:ai_declarative_foldering_architecture/features/wallet/presentation/screens/input_wallet_address_sheet.dart';
import 'package:ai_declarative_foldering_architecture/features/wallet/presentation/screens/send_atla_to_connected_wallet_sheet.dart';
import 'package:ai_declarative_foldering_architecture/libs/app_uikit/app/themes/text_styles/styles_extension.dart';
import 'package:ai_declarative_foldering_architecture/libs/app_uikit/core/mixins/navigation_mixins.dart';
import 'package:app_failure/app_failure.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/chat/presentation/chat_routes.dart';
import '../../features/home/presentation/home_routes.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/onboarding_routes.dart';
import '../../features/score/presentation/score_routes.dart';
import '../../features/user/presentation/screens/user_profiles_screen.dart';
import '../../features/user/presentation/user_routes.dart';
import '../../features/wallet/presentation/screens/convert_to_atla_params.dart';
import '../../features/wallet/presentation/screens/convert_to_atla_sheet.dart';
import '../../features/wallet/presentation/screens/input_wallet_address_sheet_params.dart';
import '../../features/wallet/presentation/screens/result_info_params.dart';
import '../../features/wallet/presentation/screens/result_info_sheet.dart';
import '../../features/wallet/presentation/screens/send_atla_to_connected_wallet_params.dart';
import '../../features/wallet/presentation/wallet_routes.dart';
import '../../libs/app_uikit/shared/widgets/app_modal_sheet.dart';
import '../../shared/widgets/tab_view_shall.dart';
import '../di.dart';
import '../../shared/presentation/app_input/app_city_input_dialog_params.dart';
import '../../shared/presentation/app_input/app_city_input_sheet.dart';
import '../../shared/presentation/app_input/app_date_input_dialog_params.dart';
import '../../shared/presentation/app_input/app_date_input_sheet.dart';
import '../../shared/presentation/app_input/app_country_input_dialog_params.dart';
import '../../shared/presentation/app_input/app_country_input_sheet.dart';
import '../../shared/presentation/app_input/app_gender_input_dialog_params.dart';
import '../../shared/presentation/app_input/app_gender_input_sheet.dart';
import '../../shared/presentation/app_input/app_height_input_dialog_params.dart';
import '../../shared/presentation/app_input/app_height_input_sheet.dart';
import '../../shared/presentation/app_input/app_text_input_dialog_params.dart';
import '../../shared/presentation/app_input/app_text_input_sheet.dart';
import '../../shared/presentation/app_input/app_weight_input_dialog_params.dart';
import '../../shared/presentation/app_input/app_weight_input_sheet.dart';

class AppRouter {
  static AppRouter? _instance;

  static AppRouter get instance {
    try{
    return _instance!;
    }catch(error,st){
      throw AppFailure.unhandledFailure(error: error, stackTrace: st);
    }
  }

  final rootNavigatorKey = GlobalKey<NavigatorState>();

  late final GoRouter _router;

  GoRouter get router => _router;

  final Listenable? refresh;
  final GoRouterRedirect? redirect;

  factory AppRouter({GoRouterRedirect? redirect, Listenable? refresh}) {
    return _instance ??= AppRouter._(redirect: redirect, refresh: refresh);
  }


  AppRouter._({
    this.redirect,
    this.refresh,
  }) {
    _router = GoRouter(
      observers: [GoRouterObserver()],
      debugLogDiagnostics: true,
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      routes: <RouteBase>[
        ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) {
              return AppShell(child: child);
            },
            routes: [
              ...buildOnboardingRoutes(),
              ...buildChatRoutes(),
              ...buildGamePlayRoutes(),
              // ...buildUserRoutes(),
              GoRoute(
                path: '/textInput',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! AppTextInputDialogParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: AppTextInputSheet(
                        initial: params.initial,
                        onSuccess: params.onSuccess,
                        onSkip: params.onSkip,
                        hint: params.hint,
                        placeholder: params.placeholder,
                        allowEmpty: params.allowEmpty,
                        maxLines: params.maxLines,
                        maxLength: params.maxLength,
                        keyboardType: params.keyboardType,
                        help: params.help,
                        textInputAction: params.textInputAction,
                        continueBtnTitle: params.continueBtnTitle,
                      ),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/heightInput',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! AppHeightInputDialogParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: AppHeightInputSheet(params: params),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/weightInput',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! AppWeightInputDialogParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: AppWeightInputSheet(params: params),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/cityInput',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! AppCityInputDialogParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: AppCityInputSheet(params: params),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/countryInput',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! AppCountryInputDialogParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: AppCountryInputSheet(params: params),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/genderInput',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! AppGenderInputDialogParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: AppGenderInputSheet(params: params),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/dateInput',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! AppDateInputDialogParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: AppDateInputSheet(params: params),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/game_limit_hit',
                pageBuilder: (context, state) {
                  final onSuccess = state.extra as AppOnSuccess<bool>?;
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: 'You have spent all the\nattempts for the game',
                      child: GameLimitHitSheet(onSuccess:onSuccess,),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              
              GoRoute(
                path: '/sendAtlaToConnectedWallet',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! SendAtlaToConnectedWalletParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: SendAtlaToConnectedWalletSheet(
                        initial: params.initial,
                        onSuccess: params.onSuccess,
                        onSkip: params.onSkip,
                        hint: params.hint,
                        placeholder: params.placeholder,
                        allowEmpty: params.allowEmpty,
                        maxLines: params.maxLines,
                        maxLength: params.maxLength,
                        max:params.max,
                        address:params.address,
                        keyboardType: params.keyboardType,
                        help: params.help,
                        textInputAction: params.textInputAction,
                        continueBtnTitle: params.continueBtnTitle,
                      ),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/InputWalletAddressSheet',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! InputWalletAddressSheetParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: InputWalletAddressSheet(
                        initial: params.initial,
                        onSuccess: params.onSuccess,
                        onSkip: params.onSkip,
                        hint: params.hint,
                        placeholder: params.placeholder,
                        allowEmpty: params.allowEmpty,
                        maxLines: params.maxLines,
                        maxLength: params.maxLength,
                        max:params.max,
                        address:params.address,
                        keyboardType: params.keyboardType,
                        help: params.help,
                        textInputAction: params.textInputAction,
                        continueBtnTitle: params.continueBtnTitle,
                      ),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),

              GoRoute(
                path: '/ConvertToAtlaSheet',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! ConvertToAtlaParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      title: params.title,
                      child: ConvertToAtlaSheet(
                        params: params,
                      ),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/resultInfo',
                pageBuilder: (context, state) {
                  final params = state.extra;
                  if (params is! ResultInfoParams) {
                    return const MaterialPage(child: SizedBox());
                  }
                  return ModalSheetPage(
                    ModalSheetConfig(
                      wrapper: (child) => BackLightBackground(child: child,resultType:params.resultType),
                      child: ResultInfoSheet(params: params,),
                      shrinkWrap: true,
                    ),
                  );
                },
              ),


              ShellRoute(
                builder: (context, state, child) => TabViewShell(child: child),
                routes: [
                  GoRoute(
                      path: '/',
                      builder: (context, state) =>
                          HomeScreen(onSuccess: (context, val) async {
                            di<AppRouter>().router.push('/onboarding');
                            HapticFeedback.lightImpact();
                            return null;
                          },),
                  routes: [
                    ...buildWalletRoutes(),
                    ...buildScoreRoutes(),
                    ...buildUserRoutes(),
                      // GoRoute(
                      //   path: 'profile',
                      //   builder: (context, state) => const UserProfilesScreen(),
                      //   routes: [],
                      // ),
                  ]),
                ],
              ),
                  ]
              ),
      ],
      errorBuilder: routingError,

      redirect: redirect,
      refreshListenable: refresh,
    );
  }

  /// Pops routes until the given [path] is the current location. If the path
  /// is not found in the stack, it performs a `go` to rebuild the stack there.
  void backTo(String path) {
    String currentLocation() =>
        _router.routerDelegate.currentConfiguration.uri.toString();

    if (currentLocation() == path) return;

    while (_router.canPop() && currentLocation() != path) {
      _router.pop();
    }

    if (currentLocation() != path) {
      _router.go(path);
    }
  }


  Widget routingError(context, GoRouterState state) {
    final error = 'Route error: ${state.error} ${state.path}';

    final failure = AppFailure.unhandledFailure(
        logMessage: error,
        error: Error(), stackTrace: StackTrace.current);
    AppLoggerService().logFailure(failure);

    return Scaffold(
      body: Center(child: error.p1()),
    );
  }
}
