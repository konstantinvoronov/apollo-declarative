import '../../models/layout/app_sizes.dart';
import '../app_element.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../smart_refresher_widget.dart';

part './base/fixed_overlaying_visible_bottom_over_scrollable_content.dart';
part './base/fixed_visible_bottom_with_flexible_content.dart';
part './base/fixed_visible_bottom_with_forced_tofill_content.dart';
part './base/fixed_visible_bottom_with_resized_content.dart';
part './base/fixed_visible_bottom_with_scrollable_content.dart';
part './base/fixed_visible_bottom_with_scrollable_expanded_content.dart';
part './base/fixed_visible_bottom_with_scrollable_expanded_content_with_refresher.dart';
part './base/keybard_and_content_sections.dart';

/*
AppLayouts
A collection of reusable “two-pane” screen layouts that pair a main content area with a fixed bottom section, exposed behind a single abstract API via redirecting factories.

Features
Overlaying: scrollable content slides under a fixed bottom pane

Flexible: body expands to fill available space above bottom pane

Forced-fill: content is stretched to fill the gap above bottom pane

Resized: content is simply resized to fit

Scrollable: combines scrolling with flexible/expanded behaviors

Pull-to-refresh: scrollable + expanded + refresh support

Keyboard-aware: automatically spaces content when the keyboard is visible
 */
/// ApppLayouts is a start of migration from enum AppLayouts and manager AppLayoutManager to sealed classes AppLayouts
sealed class AppFlexibleLayouts extends StatelessWidget implements AppElement {
  final List<Widget>? children;
  final Widget? child;

  final AppLayoutPaddings? padding;

  const AppFlexibleLayouts({super.key, this.children, this.child, this.padding, });

  @override
  Widget build(BuildContext context);

  /// Overlaying bottom sheet over a scrollable body
  factory AppFlexibleLayouts.FixedOverlayingVisibleBottomOverScrollableContent({
    Key? key,
    Widget? child,
    List<Widget>? children,
    List<Widget>? bottomChildren,
    AppLayoutPaddings? padding,
    AppLayoutPaddings? paddingBottom,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment,
  }) = FixedOverlayingVisibleBottomOverScrollableContent;

  /// Fixed bottom + flexible content
  factory AppFlexibleLayouts.FixedVisibleBottomLayoutWithFlexibleContent({
    Key? key,
    Widget? child,
    List<Widget>? children,
    List<Widget>? bottomChildren,
    AppLayoutPaddings? padding,
    AppLayoutPaddings? paddingBottom,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment,
  }) = FixedVisibleBottomLayoutWithFlexibleContent;

  /// Fixed bottom + content forced to fill
  factory AppFlexibleLayouts.FixedVisibleBottomLayoutWithForcedToFillContent({
    Key? key,
    Widget? child,
    List<Widget>? children,
    List<Widget>? bottomChildren,
    AppLayoutPaddings? padding,
    AppLayoutPaddings? paddingBottom,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment,
  }) = FixedVisibleBottomLayoutWithForcedToFillContent;

  /// Fixed bottom + content that is simply resized
  factory AppFlexibleLayouts.FixedVisibleBottomLayoutWithResizedContent({
    Key? key,
    Widget? child,
    List<Widget>? children,
    List<Widget>? bottomChildren,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment,
    AppLayoutPaddings? padding,
    AppLayoutPaddings paddingBottom,
  }) = FixedVisibleBottomLayoutWithResizedContent;

  /// Fixed bottom + scrollable, flexible content
  factory AppFlexibleLayouts.FixedVisibleBottomLayoutWithScrollableFlexibleContent({
    Key? key,
    Widget? child,
    List<Widget>? children,
    List<Widget>? bottomChildren,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment,
    AppLayoutPaddings? padding,
    ScrollController? extController,
  }) = FixedVisibleBottomLayoutWithScrollableFlexibleContent;

  /// Fixed bottom + scrollable + expanded content
  factory AppFlexibleLayouts.FixedVisibleBottomLayoutWithScrollableExpandedContent({
    Key? key,
    Widget? child,
    List<Widget>? children,
    List<Widget>? bottomChildren,
    AppLayoutPaddings? padding,
    AppLayoutPaddings? paddingBottom,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment,
    ScrollController? controller,
  }) = FixedVisibleBottomLayoutWithScrollableExpandedContent;

  /// Fixed bottom with refreshable scrollable content and optional slivers.
  const factory AppFlexibleLayouts.fixedVisibleBottomLayoutWithScrollableExpandedContentWithRefresher({
    Key? key,
    Widget? child,
    List<Widget>? children,
    List<Widget> slivers,
    required RefreshController refreshController,
    List<Widget>? bottomChildren,
    AppLayoutPaddings? padding,
    bool reversedSliver,
    bool enablePullUp,
    ScrollController? controller,
    VoidCallback? onRefresh,
  }) = FixedVisibleBottomLayoutWithScrollableExpandedContentWithRefresher;

  /// Keyboard + content sections layout
  factory AppFlexibleLayouts.KeybardAndContentSections({
    Key? key,
    Widget? child,
    List<Widget>? children,
    List<Widget>? bottomChildren,
    AppLayoutPaddings? padding,
    AppLayoutPaddings? paddingBottom,
    MainAxisAlignment mainAxisAlignment,
    CrossAxisAlignment crossAxisAlignment,
  }) = KeybardAndContentSections;
}

abstract class AppTwoVisibleAreasLayout extends AppFlexibleLayouts {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget>? bottomChildren;
  final AppLayoutPaddings? paddingBottom;

  const AppTwoVisibleAreasLayout({
    super.key,
    super.child,
    super.children,
    super.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.bottomChildren,
    this.paddingBottom,
  });
}



enum AppLayoutPaddings {
  small(AppSizes.gap2x,AppSizes.gap2x,AppSizes.gap2x,AppSizes.gap2x),
  medium(AppSizes.gap4x,AppSizes.gap4x,AppSizes.gap4x,AppSizes.gap4x),
  large(AppSizes.gap6x,AppSizes.gap6x,AppSizes.gap6x,AppSizes.gap6x),

  smallVertical(0,AppSizes.gap2x,0,AppSizes.gap2x),
  mediumVertical(0,AppSizes.gap4x,0,AppSizes.gap4x),
  largeVertical(0,AppSizes.gap6x,0,AppSizes.gap6x),

  smallHorizontal(AppSizes.gap2x,0,AppSizes.gap2x,0),
  mediumHorizontal(AppSizes.gap4x,0,AppSizes.gap4x,0),
  largeHorizontal(AppSizes.gap6x,0,AppSizes.gap6x,0),

  smallTop(0,AppSizes.gap2x,0,0),
  mediumTop(0,AppSizes.gap4x,0,0),
  largeTop(0,AppSizes.gap6x,0,0),

  smallBottom(0,0,0,AppSizes.gap2x),
  mediumBottom(0,0,0,AppSizes.gap4x),
  largeBottom(0,0,0,AppSizes.gap6x),

  /// размер для AppModalSheet заголовка
  skillSheet(AppSizes.gap4x,AppSizes.gap2x,AppSizes.gap4x,0),
  skillBottomSheet(AppSizes.gap4x,AppSizes.gap2x,AppSizes.gap4x,AppSizes.gap6x),
  smallSheet(AppSizes.gap4x,AppSizes.gap2x,AppSizes.gap4x,AppSizes.gap6x,),
  mediumSheet(0,0,0,AppSizes.gap4x),
  largeSheet(0,0,0,AppSizes.gap6x),

  zero(0,0,0,0);

  final double left;
  final double top;
  final double right;
  final double bottom;

  EdgeInsets get insets => EdgeInsets.fromLTRB(left, top, right, bottom);

  const AppLayoutPaddings(this.left,this.top,this.right,this.bottom);
}
