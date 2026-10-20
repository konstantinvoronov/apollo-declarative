
part of '../app_flexible_layouts.dart';


///
class FixedOverlayingVisibleBottomOverScrollableContent extends AppTwoVisibleAreasLayout {
  const FixedOverlayingVisibleBottomOverScrollableContent({
    super.key,
    super.child,
    super.children,
    super.bottomChildren,
    super.padding,
    super.crossAxisAlignment = CrossAxisAlignment.start,
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.paddingBottom,
  });

  @override
  Widget build(BuildContext context) {
    final AppSizes appSizes = AppSizes.of(context);
    // return buildBottom();

    return Padding(
        padding: padding?.insets ?? EdgeInsets.symmetric(horizontal: AppSizes.gap4h),
        child: Stack(
          children: [
            SingleChildScrollView(
                child: child ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children ?? [],
                    ),
              ),
            buildBottom()
          ],
        ));
  }

  @override
  Widget buildBottom() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Column(children: [
        ...bottomChildren ?? [],
        AppSizes.vgap2x
      ],),
    );
  }
}
