import 'package:flutter/material.dart';
import 'package:footunion/libs/app_uikit/app/consts/app_sizes.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  final Widget? background;

  const AppShell({super.key, required this.child, this.background});

  @override
  Widget build(BuildContext context) {
    final sizes = AppSizes.of(context);

    return Stack(
      children: [
        background ?? const _DefaultAppBackground(),
        Center(
          child: SizedBox(
            width: sizes.effectiveScreenWidth,
            child: child,
          ),
        ),
      ],
    );
  }
}

class _DefaultAppBackground extends StatelessWidget {
  const _DefaultAppBackground();
  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
        // gradient/image if needed
      ),
      child: SizedBox.expand(),
    );
  }
}
