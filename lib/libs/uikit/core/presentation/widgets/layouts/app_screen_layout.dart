import '../../models/layout/app_sizes.dart';
import '../app_element.dart';
import '../../models/themes/app_theme.dart';
import '../app_bar.dart';
import 'package:flutter/material.dart';


part './screen_layouts/app_blank_screen_layout.dart';
part './screen_layouts/app_simple_screen_layout.dart';

/// ApppLayouts is a start of migration from enum AppLayouts and manager AppLayoutManager to sealed classes AppLayouts
class AppScreenLayout extends StatelessWidget implements AppElement {
  final List<Widget>? children;
  final Widget? child;

  final AppScreenLayoutPaddings? padding;

  const AppScreenLayout({super.key, this.children, this.child, this.padding, });

  @override
  Widget build(BuildContext context) => SizedBox.shrink();

  /// No screen elements only scaffold and paddings standart routing trough MaterialPage
  factory AppScreenLayout.AppBlankScreen({Key? key,
    Widget? child,
    Widget? title,
    AppScreenBar? appBar,
    AppScreenLayoutPaddings? padding,
    bool? extendBodyBehindAppBar,
    bool safeArea,
    Color? backgroundColor,}) = AppBlankScreen;

  const factory AppScreenLayout.AppSimpleScreenLayout({
    Key? key,
    required Widget child,
    Widget? title,
    bool unFocus,
    AppScreenLayoutPaddings? padding,
    AppScreenBar? appBar,
    bool? extendBodyBehindAppBar,
    Color? bgColor,
  }) = AppSimpleScreenLayout;

}


enum AppScreenLayoutPaddings {
  medium,
  zero;

  EdgeInsets of(BuildContext context) {
    switch (this) {
      case AppScreenLayoutPaddings.medium:
        return EdgeInsets.only(
          left:   AppSizes.gap2w,
          right:  AppSizes.gap2w,
          top:    AppSizes.gap4h,
          bottom: AppSizes.gap6h,
        );
      case AppScreenLayoutPaddings.zero:
        return EdgeInsets.zero;
    }
  }
}
