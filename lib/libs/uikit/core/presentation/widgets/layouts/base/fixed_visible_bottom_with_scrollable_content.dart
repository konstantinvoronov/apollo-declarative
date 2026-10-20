part of '../app_flexible_layouts.dart';

///
class FixedVisibleBottomLayoutWithScrollableFlexibleContent extends AppTwoVisibleAreasLayout {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final ScrollController? extController;
  final ScrollController _controller = ScrollController();

  FixedVisibleBottomLayoutWithScrollableFlexibleContent({super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.extController, super.child,super.children,super.bottomChildren,super.padding});


  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    return Padding(
        padding: padding?.insets ?? EdgeInsets.symmetric(horizontal: AppSizes.gap4w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                controller: extController ?? _controller,
                physics: ClampingScrollPhysics(),
                child: child ??
                    Column(
                      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
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
