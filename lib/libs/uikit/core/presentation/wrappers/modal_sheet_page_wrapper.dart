import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../models/modal_sheet_config.dart';
import '../../../../../shared/core/presentation/widgets/layouts/app_screens_layouts_extension.dart';

class ModalSheetPageWrapper<T> extends Page<T> {
  const ModalSheetPageWrapper(this.cfg, {super.key});

  final ModalSheetConfig cfg;

  @override
  Route<T> createRoute(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height*0.9;
    final double? computedHeight = cfg.fullScreen
        ? screenHeight
        : (cfg.shrinkWrap ? null : cfg.height ?? screenHeight);
    final scrollCtrl = ScrollController();

    return ModalSheetRoute<T>( //ModalBottomSheetRoute
      scrollController: scrollCtrl,
      isDismissible: true,
      enableDrag: true,
      // backgroundColor: Colors.transparent,
      modalBarrierColor: Colors.black45,
      settings: this,
      expanded: cfg.fullScreen,
      builder: (_) {
        return AppScreenLayouts.appModalBottomSheet(
        shrinkWrap:      cfg.shrinkWrap,
        backSupport:     cfg.backSupport,
        fullScreen:      cfg.fullScreen,
        childTopPadding: cfg.childTopPadding,
        childBottomPadding: cfg.childBottomPadding,
        title:           cfg.title ?? '',
        height:          computedHeight,
        backgroundColor: cfg.backgroundColor,
        child:           cfg.child,
      );},
    );
  }
}



