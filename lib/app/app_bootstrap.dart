import 'dart:async';
import 'package:flutter/material.dart';
import '../core/domain/services/i_app_local_notification_service.dart';
import '../core/domain/services/i_app_push_notification_service.dart';
import 'di.dart';
import 'routing/app_router.dart';

class AppBootstrap extends StatefulWidget {
  final Widget child;

  const AppBootstrap({super.key, required this.child});
  @override
  State<AppBootstrap> createState() => _AppBootstrapState();
}

class _AppBootstrapState extends State<AppBootstrap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(
        di<AppRouter>().initializeNotificationRouting(
          di<IAppLocalNotificationService>(),
          di<IAppPushNotificationService>(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Once ready, show your real app
    return widget.child;
  }
}
