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
import 'dart:async';

import 'package:app_failure/app_failure.dart';
import '../../core/domain/models/app_notification_interaction_model.dart';
import '../../core/domain/services/i_app_local_notification_service.dart';
import '../../core/domain/services/i_app_push_notification_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/app_logger_service.dart';
import '../../features/about_apollo/presentation/routing.dart';
import '../../libs/uikit/core/presentation/widgets/layouts/app_flexible_layouts.dart';
import '../../shared/core/presentation/widgets/layouts/app_screens_layouts_extension.dart';
import '../app_shell.dart';
import '../config/navigation_conf.dart';
import '../di.dart';
import 'observers.dart';

class AppRouter {
  static AppRouter? _instance;

  static AppRouter get instance {
    try {
      return _instance!;
    } catch (error, st) {
      throw AppFailure.unhandledFailure(error: error, stackTrace: st);
    }
  }

  final rootNavigatorKey = appNavigatorKey;

  late final GoRouter _router;

  GoRouter get router => _router;

  final Listenable? refresh;
  final GoRouterRedirect? redirect;
  final _notificationSubscriptions =
      <StreamSubscription<AppResult<AppNotificationInteractionModel>>>[];
  final _openedNotifications = <String>{};
  bool _disposed = false;
  Future<void>? _notificationRouting;

  Future<void> initializeNotificationRouting(
    IAppLocalNotificationService local,
    IAppPushNotificationService push,
  ) => _notificationRouting ??= _subscribeToNotificationInteractions(
    local,
    push,
  );

  Future<void> _subscribeToNotificationInteractions(
    IAppLocalNotificationService local,
    IAppPushNotificationService push,
  ) async {
    if (_disposed) return;
    _notificationSubscriptions.add(
      local.interactions.listen(_openNotificationResult),
    );
    _notificationSubscriptions.add(
      push.interactions.listen(_openNotificationResult),
    );
    _openNotificationResult(await local.consumeLaunchInteraction());
    _openNotificationResult(await push.consumeLaunchInteraction());
  }

  void _openNotificationResult(
    AppResult<AppNotificationInteractionModel?> result,
  ) {
    if (_disposed) return;
    result.fold(
      (interaction) {
        if (interaction == null) return;
        if (interaction.destination != 'home') {
          AppLoggerService().log(
            'notifications.routing.destination.rejected',
            'notifications',
          );
          return;
        }
        if (!_openedNotifications.add(interaction.notificationId)) return;
        if (_openedNotifications.length > 128) {
          _openedNotifications.remove(_openedNotifications.first);
        }
        _router.go('/');
        AppLoggerService().log('notifications.routing.opened', 'notifications');
      },
      (failure) {
        AppLoggerService().logFailure(failure, context: 'notification routing');
      },
    );
  }

  factory AppRouter({GoRouterRedirect? redirect, Listenable? refresh}) {
    return _instance ??= AppRouter._(redirect: redirect, refresh: refresh);
  }

  AppRouter._({this.redirect, this.refresh}) {
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
            ...buildAboutApolloRoutes(di),
            // ...buildUserRoutes(),
            // GoRoute(
            //   path: 'profile',
            //   builder: (context, state) => const UserProfilesScreen(),
            //   routes: [],
            // ),
          ],
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

  Widget routingError(BuildContext context, GoRouterState state) {
    final error = 'Route error: ${state.error} ${state.path}';

    final failure = AppFailure.unhandledFailure(
      logMessage: error,
      error: state.error ?? StateError(error),
      stackTrace: StackTrace.current,
    );
    AppLoggerService().logFailure(failure);

    return AppScreenLayouts.appBasicScreen(
      child: AppFlexibleLayouts.FixedVisibleBottomLayoutWithForcedToFillContent(
        padding: AppLayoutPaddings.zero,
        paddingBottom: AppLayoutPaddings.zero,
        child: Center(child: Text(error)),
      ),
    );
  }

  Future<void> dispose() async {
    _disposed = true;
    for (final subscription in _notificationSubscriptions) {
      await subscription.cancel();
    }
    _router.dispose();
    _instance = null;
  }
}
