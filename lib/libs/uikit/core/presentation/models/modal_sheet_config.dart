import 'package:flutter/material.dart';

@immutable
class ModalSheetConfig {
  const ModalSheetConfig({
    required this.child,
    this.shrinkWrap = false,
    this.fullScreen  = false,
    this.dismissible = true,
    this.childTopPadding = 0,
    this.childBottomPadding,
    this.title,
    this.backSupport = false,
    this.backgroundColor,
    this.height,
  });

  final Widget  child;
  final bool    shrinkWrap;
  final bool    fullScreen;
  final bool    dismissible;
  final double  childTopPadding;
  final double? childBottomPadding;
  final String? title;
  final bool    backSupport;
  final Color?  backgroundColor;
  final double? height;
}



