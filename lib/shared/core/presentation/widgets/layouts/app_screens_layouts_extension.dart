import 'package:flutter/material.dart';
import '../../../../../libs/uikit/core/presentation/widgets/layouts/app_screen_layout.dart';

import '../../../../../libs/uikit/core/presentation/widgets/app_bar.dart';
import 'app_basic_screen_layout.dart';
import 'app_green_gradient_screen_layout.dart';

extension AppScreenLayouts on AppScreenLayout {

  static AppScreenLayout appBasicScreen({
    Key? key,
    Widget? child,
    AppScreenBar? appBar,
    List<Widget>? children,
    AppScreenLayoutPaddings? padding,
    Widget? title,
    Color? backgroundColor,
    bool? extendBodyBehindAppBar,
  }) {
    return AppBasicScreen(
      key: key,
      child: child,
      children: children,
      padding: padding,
      appBar: appBar,
      title: title,
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }

  static AppScreenLayout backLightScreen({
    Key? key,
    Widget? child,
    AppScreenBar? appBar,
    List<Widget>? children,
    AppScreenLayoutPaddings? padding,
    Widget? title,
    Color? backgroundColor,
    bool? extendBodyBehindAppBar,
  }) {
    return AppBasicScreen(
      key: key,
      child: child,
      children: children,
      padding: padding,
      appBar: appBar,
      title: title,
      backgroundColor: backgroundColor,
      backgroundBuilder: (child) => BackLightBackground(child: child),
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }

  static AppScreenLayout appGreenGradientScreen({
    Key? key,
    Widget? child,
    AppScreenBar? appBar,
    List<Widget>? children,
    AppScreenLayoutPaddings? padding,
    Widget? title,
    Color? backgroundColor,
    bool? extendBodyBehindAppBar,
  }) {
    return AppBasicScreen(
      key: key,
      child: child,
      children: children,
      padding: padding,
      appBar: appBar,
      title: title,
      backgroundColor: backgroundColor,
      backgroundBuilder: (child) => GreenGradientBackground(child: child),
      extendBodyBehindAppBar: extendBodyBehindAppBar,
    );
  }
}
