import 'package:flutter/material.dart';
import '../../../../../libs/uikit/core/presentation/widgets/layouts/app_screen_layout.dart';
import '../../../../../libs/uikit/core/presentation/widgets/layouts/screen_layouts/app_modal_bottom_sheet_layout.dart';

import '../../../../../libs/uikit/core/presentation/widgets/app_bar.dart';
import 'app_basic_screen_layout.dart';
import 'app_green_gradient_screen_layout.dart';

extension AppScreenLayouts on AppScreenLayout {

  static AppScreenLayout appModalBottomSheet({
    Key? key,
    required Widget child,
    required bool shrinkWrap,
    double? height,
    double? childTopPadding,
    double? childBottomPadding,
    String title = '',
    Color? backgroundColor,
    bool backSupport = false,
    bool fullScreen = false,
  }) {
    return AppModalBottomSheetLayout(
      key: key,
      shrinkWrap: shrinkWrap,
      height: height,
      childTopPadding: childTopPadding,
      childBottomPadding: childBottomPadding,
      title: title,
      backgroundColor: backgroundColor,
      backSupport: backSupport,
      fullScreen: fullScreen,
      child: child,
    );
  }

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
