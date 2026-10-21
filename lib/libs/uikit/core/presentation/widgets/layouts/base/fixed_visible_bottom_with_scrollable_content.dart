part of '../app_flexible_layouts.dart';

///
class FixedVisibleBottomLayoutWithScrollableFlexibleContent extends AppTwoVisibleAreasLayout {
  final ScrollController? extController;

  const FixedVisibleBottomLayoutWithScrollableFlexibleContent({super.key,
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.crossAxisAlignment = CrossAxisAlignment.start,
    this.extController, super.child,super.children,super.bottomChildren,super.padding});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding?.insets ?? EdgeInsets.symmetric(horizontal: AppSizes.gap4w),
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                controller: extController,
                physics: ClampingScrollPhysics(),
                child: child ??
                    Column(
                      mainAxisAlignment: mainAxisAlignment,
                      crossAxisAlignment: crossAxisAlignment,
                      mainAxisSize: MainAxisSize.min,
                      children: children ?? [],
                    ),
              ),
            ),
            buildBottom()
          ],
        ));
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
