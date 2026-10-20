part of '../app_flexible_layouts.dart';

///
class FixedVisibleBottomLayoutWithResizedContent extends AppTwoVisibleAreasLayout {

  const FixedVisibleBottomLayoutWithResizedContent({super.key,super.child,super.children,super.bottomChildren,super.padding,
    super.paddingBottom,
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    return Padding(
        padding: padding?.insets ?? EdgeInsets.symmetric(horizontal: AppSizes.gap4w),
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: FittedBox(alignment: Alignment.center,
                fit: BoxFit.contain,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: child ?? Column(
                      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                      crossAxisAlignment:crossAxisAlignment ?? CrossAxisAlignment.start,
                      children: children ?? []),
                ),
              ),
            ),
            buildBottom()
          ],
        ));
  }

  Widget buildBottom() {
    return Column(children: [
      ...bottomChildren ?? [],
      SizedBox(height: AppSizes.gap2w,)
    ],);
  }
}
