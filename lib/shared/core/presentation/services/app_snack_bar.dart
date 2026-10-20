import 'package:flutter/material.dart';

enum SnackBarType { error, success, warning }

class AppSnackBar {
  final GlobalKey<NavigatorState> navigatorKey;

  BuildContext? get _context => navigatorKey.currentContext;

  const AppSnackBar(this.navigatorKey);

  void showSnackBar(String? message, {SnackBarType type = SnackBarType.error}) {
    final context = _context;
    if (context == null) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message ?? 'Empty message')));
  }

  void success(String message) =>
      showSnackBar(message, type: SnackBarType.success);
  void warning(String message) =>
      showSnackBar(message, type: SnackBarType.warning);
  void error(String message) => showSnackBar(message, type: SnackBarType.error);
}
