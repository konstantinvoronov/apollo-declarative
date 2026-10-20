import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../libs/uikit/core/presentation/models/layout/app_sizes.dart';
import '../../../../../libs/uikit/core/presentation/models/themes/app_theme.dart';
import '../../../../../libs/uikit/core/presentation/widgets/layouts/app_screen_layout.dart';

import '../../../../../libs/uikit/core/presentation/widgets/app_bar.dart';

class AppBasicScreen extends AppScreenLayout {
  @override
  final Widget? child;
  final Widget? title;
  final Color? backgroundColor;
  final Widget Function(Widget)? backgroundBuilder;
  final AppScreenBar? appBar;
  final bool? extendBodyBehindAppBar;

  const AppBasicScreen({this.appBar,super.key, this.extendBodyBehindAppBar, this.backgroundBuilder,this.child, super.children, super.padding, this.backgroundColor, this.title})
      : assert(children != null || child != null, 'You must provide either child or children');


  factory AppBasicScreen.backLigntScreen(
      {AppScreenBar? appBar, Key? key, bool? extendBodyBehindAppBar,
        Widget? child, List<Widget>? children, AppScreenLayoutPaddings? padding,
        Color? backgroundColor, Widget? title}){
    return AppBasicScreen(appBar: appBar,
        key: key,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        backgroundBuilder: (child) => BackLightBackground(child: child,),
        child: child,
        children: children,
        padding: padding,
        backgroundColor: backgroundColor,
        title: title,);
  }

  factory AppBasicScreen.greenGradientScreen(
      {AppScreenBar? appBar, Key? key, bool? extendBodyBehindAppBar,
        Widget? child, List<Widget>? children, AppScreenLayoutPaddings? padding,
        Color? backgroundColor, Widget? title}){
    return AppBasicScreen(appBar: appBar,
      key: key,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundBuilder: (child) => BackLightBackground(child: child,),
      child: child,
      children: children,
      padding: padding,
      backgroundColor: backgroundColor,
      title: title,);
  }



  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
    extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
    backgroundColor: theme.colors.bgPrimary,
    appBar: appBar,
    body:WrapInBackground(child:SafeArea(child: Padding(
      padding: padding?.of(context) ?? EdgeInsets.zero,
          child: child ??
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children ?? [],
              )),
        ),backgroundBuilder: backgroundBuilder));
  }

  Widget WrapInBackground({required Widget child, Widget Function(Widget)? backgroundBuilder}){
    return backgroundBuilder?.call(child) ?? child;
  }


}

class BackLightBackground extends StatelessWidget {
  final Widget child;
  const BackLightBackground({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
      final appSizes = AppSizes.of(context);

      return Stack(
        children: [
          Positioned(
            left: appSizes.ssh(-409),
            top: appSizes.ssh(-690),
            child: SizedBox(
              width: appSizes.ssh(418 * 3), // large glow size
              height: appSizes.ssh(418 * 3),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color.fromRGBO(226, 255, 232, 0.3),
                      Colors.transparent,
                    ],
                    radius: 0.5,
                    stops: const [0.0, 0.9  ],
                    tileMode: TileMode.decal,
                  ),
                ),
              ),
            ),
          ),
          child,
        ],
      );
  }
}
class GreenGradientBackground extends StatelessWidget {
  final Widget child;
  const GreenGradientBackground({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: IgnorePointer(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.66,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xCC30D9BA),
                    const Color(0x00197363),
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
