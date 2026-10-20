part of '../app_flexible_layouts.dart';

///
class FixedVisibleBottomLayoutWithScrollableExpandedContent extends AppTwoVisibleAreasLayout {
  final ScrollController? controller;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const FixedVisibleBottomLayoutWithScrollableExpandedContent(
      {super.key,
      super.child,
      super.children,
      super.bottomChildren,
      super.padding=AppLayoutPaddings.medium,
      super.paddingBottom,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.controller});

  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(padding: padding?.insets ?? EdgeInsets.symmetric(horizontal: appSizes.horizontalPaddingDialog),
              child: SingleChildScrollView(
                controller: controller,
                child: child ??
                    Column(
                      mainAxisAlignment: mainAxisAlignment,
                      crossAxisAlignment: crossAxisAlignment,
                      children: children ?? [],
                    ),
              ),
            )),
        Padding(padding: paddingBottom?.insets ?? padding?.insets ?? EdgeInsets.symmetric(horizontal: appSizes.horizontalPaddingDialog), child: buildBottom())
      ],
        );
  }

  Widget buildBottom() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...bottomChildren ?? [],
      ],);
  }
}
