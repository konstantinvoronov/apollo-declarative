
part of '../app_screen_layout.dart';

/// AppBlankScreen - only scaffold, not appbar
///
class AppBlankScreen  extends AppScreenLayout {
  @override
  final Widget? child;
  final Widget? title;
  final Color? backgroundColor;
  final AppScreenBar? appBar;
  final bool? extendBodyBehindAppBar;
  final bool safeArea;

  const AppBlankScreen(
      {super.key, this.appBar, this.extendBodyBehindAppBar, this.safeArea = true, this.child, super.children, super.padding, this.backgroundColor, this.title})
      : assert(children != null || child != null, 'You must provide either child or children');


  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
        backgroundColor: backgroundColor ?? theme.colors.bgPrimary,
        body: WrapInSafeArea(safeArea, Padding(
          padding: padding?.of(context) ?? EdgeInsets.zero,
          child: child ??
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children ?? [],
              ),
        )));
  }

  Widget WrapInSafeArea(bool safeArea, Widget child,) => (safeArea) ? child : SafeArea(child: child);
}