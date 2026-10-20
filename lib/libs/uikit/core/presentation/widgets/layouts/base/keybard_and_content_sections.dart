part of '../app_flexible_layouts.dart';

///
class KeybardAndContentSections extends AppTwoVisibleAreasLayout {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const KeybardAndContentSections({super.key,
    super.child,
    super.children,
    super.bottomChildren,
    super.padding,
    super.paddingBottom,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.crossAxisAlignment = CrossAxisAlignment.end});


  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    double keyboardHeight = MediaQuery.of(context).size.width * 2 / 3;
    return  Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment:crossAxisAlignment,
        mainAxisSize: MainAxisSize.min, children: [
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 150), // Minimum height for content
              child: Padding(padding: padding?.insets ?? EdgeInsets.symmetric(horizontal: appSizes.horizontalPaddingDialog), child: buildSection(children)),
            ),
          ),
          Container(
              height: keyboardHeight + AppSizes.customKeyboardGap,
              child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: keyboardHeight + AppSizes.customKeyboardGap), // Minimum height for content
                  child: Padding(
                      padding: paddingBottom?.insets ?? padding?.insets ?? EdgeInsets.symmetric(horizontal: appSizes.horizontalPaddingDialog),
                      child: buildSection(bottomChildren)))),
        ]);
  }

  Widget buildSection(List<Widget>? children) {
    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment:crossAxisAlignment,
      children: [
      ...children ?? [],
    ],);
  }
}