part of '../app_screen_layout.dart';

/// AppSimpleLayout - simple Layout with customappbar
class AppSimpleScreenLayout extends AppScreenLayout {
  final Widget? title;
  final bool unFocus;
  final AppScreenBar? appBar;
  final bool? extendBodyBehindAppBar;
  final Color? bgColor;

  @override
  final Widget child;

  const AppSimpleScreenLayout(
      {
        super.key,
        required this.child,
        super.padding,
        this.extendBodyBehindAppBar,
        this.title,
        this.appBar,this.bgColor,
        this.unFocus=true});

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Scaffold(
      appBar: appBar ??
            AppScreenBar(
            title: title,
            isBackButtonVisible: true,
          ),
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? false,
      backgroundColor: bgColor ?? theme.colors.bgSecondary,
      body: Padding(padding: (padding ?? AppScreenLayoutPaddings.medium).of(context), child: ifUnFocus(child, context)),
    );
  }

  Widget ifUnFocus(Widget child, BuildContext context) {
    return (unFocus)
        ? GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: child)
        : child;
  }
}