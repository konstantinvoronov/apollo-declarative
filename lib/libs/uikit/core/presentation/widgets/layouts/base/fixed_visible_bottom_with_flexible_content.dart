
part of '../app_flexible_layouts.dart';

class FixedVisibleBottomLayoutWithFlexibleContent extends AppTwoVisibleAreasLayout {

  FixedVisibleBottomLayoutWithFlexibleContent(
      {super.key,
      super.children,
      super.child,
      super.padding,
      super.bottomChildren,
      super.paddingBottom,
      super.mainAxisAlignment = MainAxisAlignment.start,
      super.crossAxisAlignment = CrossAxisAlignment.start});

  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Padding(padding: padding?.insets ?? EdgeInsets.symmetric(horizontal: appSizes.horizontalPaddingDialog),
              child: buildTop()
          ),
        ),
        Padding(padding: paddingBottom?.insets ?? padding?.insets ?? EdgeInsets.symmetric(horizontal: appSizes.horizontalPaddingDialog),
            child: buildBottom()
        ),
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

  Widget buildTop(){
    return child ?? Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      children: children??[],);
  }

}