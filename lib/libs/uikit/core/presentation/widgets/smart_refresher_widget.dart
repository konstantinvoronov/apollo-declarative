import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SmartRefresherWidget extends StatelessWidget {
  final RefreshController controller;
  final VoidCallback? onRefresh;
  final Widget child;
  final bool? reverse;
  final bool? primary;
  final bool enablePullDown;
  final bool enablePullUp;
  final ScrollController? scrollController;

  const SmartRefresherWidget({
    super.key,
    required this.controller,
    required this.onRefresh,
    required this.child,
    this.reverse,
    this.primary,
    this.scrollController,
    this.enablePullDown = true,
    this.enablePullUp = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RefreshConfiguration(
      headerBuilder: () => MaterialClassicHeader(
        backgroundColor: colorScheme.surface,
        color: colorScheme.onSurface,
      ),
      child: SmartRefresher(
        scrollDirection: Axis.vertical,
        onRefresh: onRefresh,
        controller: controller,
        primary: primary,
        reverse: reverse,
        enablePullDown: enablePullDown,
        enablePullUp: enablePullUp,
        child: child,
      ),
    );
  }
}
