part of '../app_flexible_layouts.dart';

class FixedVisibleBottomLayoutWithScrollableExpandedContentWithRefresher
    extends AppTwoVisibleAreasLayout {
  final ScrollController? controller;
  final RefreshController refreshController;
  final VoidCallback? onRefresh;
  final List<Widget> slivers;
  final bool reversedSliver;
  final bool enablePullUp;

  const FixedVisibleBottomLayoutWithScrollableExpandedContentWithRefresher({
    super.key,
    super.child,
    super.children,
    super.bottomChildren,
    super.padding,
    required this.refreshController,
    this.onRefresh,
    this.slivers = const [],
    this.reversedSliver = false,
    this.enablePullUp = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding?.insets ??
          const EdgeInsets.symmetric(horizontal: AppSizes.gap4x),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SafeArea(
              child: SmartRefresherWidget(
                enablePullUp: enablePullUp,
                controller: refreshController,
                onRefresh: onRefresh,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  controller: controller,
                  reverse: reversedSliver,
                  slivers: [
                    ...slivers,
                    SliverToBoxAdapter(
                      child: child ??
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: children ?? [],
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildBottom(),
        ],
      ),
    );
  }

  Widget buildBottom() {
    return SafeArea(
      child: Column(children: [...bottomChildren ?? []]),
    );
  }
}
