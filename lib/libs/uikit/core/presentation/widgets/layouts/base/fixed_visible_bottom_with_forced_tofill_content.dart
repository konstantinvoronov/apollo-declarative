part of '../app_flexible_layouts.dart';

///
class FixedVisibleBottomLayoutWithForcedToFillContent extends AppTwoVisibleAreasLayout {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const FixedVisibleBottomLayoutWithForcedToFillContent({
    super.key,
    super.child,
    super.children,
    super.bottomChildren,
    super.padding,
    super.paddingBottom,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Expanded(
          child: Padding(padding: padding?.insets ?? EdgeInsets.symmetric(horizontal: appSizes.horizontalPaddingDefault), child: buildTop()),
        ),
        Padding(padding: paddingBottom?.insets ?? padding?.insets ?? EdgeInsets.symmetric(horizontal: appSizes.horizontalPaddingDefault), child: buildBottom()),
      ],
    );
  }

  Widget buildBottom() {
    return SafeArea(child: Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
      ...bottomChildren ?? [],
      const SizedBox(height: AppSizes.gap4x),
    ],));
  }

  Widget buildTop(){
    return child ?? Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children??[],);
  }

}
