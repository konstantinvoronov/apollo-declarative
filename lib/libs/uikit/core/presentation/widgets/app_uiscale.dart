import 'dart:math' as math;
import '../models/layout/app_sizes.dart';
import 'package:flutter/material.dart';

class AppUiScaleWidget extends InheritedWidget {
  final AppSizes sizes;

  const AppUiScaleWidget._({
    required this.sizes,
    required Widget child,
    super.key,
  }) : super(child: child);

  factory AppUiScaleWidget({
    required BuildContext context,
    required Widget child,
    required double designWidth,   // e.g. 390
    required double designHeight,  // e.g. 844
    double? widthLimitRatio,       // optional: e.g. 2/3; default = designWidth/designHeight
    Key? key,
  }) {
    assert(designWidth > 0 && designHeight > 0);


    final mq = MediaQuery.of(context);
    final size = mq.size;

    final horizontalSafe = mq.viewPadding.left + mq.viewPadding.right;
    final verticalSafe   = mq.viewPadding.top  + mq.viewPadding.bottom;
    final safeW = math.max(0.0, size.width); // we dont care about horizontal safe area
    final safeH = math.max(0.0, size.height - verticalSafe);

    // Cap width by aspect ratio using safe dimensions.
    final ratio = widthLimitRatio ?? (designWidth / designHeight);
    final cappedSafeW = math.min(safeW, safeH * ratio);

    // Scales vs design (use safe/capped width and safe height).
    final sx = cappedSafeW / designWidth;
    final sy = safeH       / designHeight;
    final s  = math.min(sx, sy); // uniform scale for text, radii, etc.

    // 3) Init sizes and store effective stage (for AppShell constraints).
    final sizes = AppSizes()..init(sx: s, sy: s, s: s,effectiveScreenWidth:cappedSafeW,effectiveScreenHeight:safeH,paddingTop: mq.viewPadding.top);

    final mediaWithTextScale = mq.copyWith(
      textScaler: TextScaler.linear(s),
    );

    return AppUiScaleWidget._(sizes: sizes,  child: MediaQuery(data: mediaWithTextScale, child:child), key: key);
  }

  static AppSizes of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppUiScaleWidget>()!.sizes;

  @override
  bool updateShouldNotify(covariant AppUiScaleWidget old) => sizes != old.sizes;
}
