import 'package:flutter/material.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';


/// A router page with two visible states: compact and full-screen.
///
/// The sheet opens at [compactExtent] by default and snaps either back to that
/// size or to full-screen. While it approaches full-screen, its rounded
/// corners, elevation, and drag handle disappear so the content reads as a
/// regular page.
///
/// The route also has a hidden `0.0` stop, which is used only for dismissal.
class AlternativeModalSheetPage<T> extends SheetPage<T> {
  static final _snapSpring = SpringDescription.withDampingRatio(
    mass: 0.5,
    stiffness: 900,
    ratio: 1.0,
  );

  AlternativeModalSheetPage({
    required Widget child,
    super.key,
    super.name,
    super.arguments,
    double compactExtent = 0.55,
    bool startsExpanded = false,
    bool maintainState = true,
    bool dismissible = true,
    bool draggable = true,
    Color? barrierColor,
    Color? backgroundColor,
    double cornerRadius = 30,
    double elevation = 8,
    bool showDragHandle = true,
    Color? dragHandleColor,
    double morphStartExtent = 0.88,
    Duration duration = const Duration(milliseconds: 400),
    Curve animationCurve = Curves.easeOutCubic,
  })  : assert(
          compactExtent > 0 && compactExtent < 1,
          'compactExtent must be between 0 and 1.',
        ),
        assert(
          morphStartExtent >= compactExtent && morphStartExtent < 1,
          'morphStartExtent must be at least compactExtent and below 1.',
        ),
        super(
          child: child,
          maintainState: maintainState,
          initialExtent: startsExpanded ? 1 : compactExtent,
          stops: <double>[0, compactExtent, 1],
          draggable: draggable,
          fit: SheetFit.expand,
          resizable: true,
          snapSpring: _snapSpring,
          snapToDragDirection: true,
          animationCurve: animationCurve,
          duration: duration,
          barrierColor: barrierColor ?? const Color(0x73000000),
          barrierDismissible: dismissible,
          decorationBuilder: (context, sheetChild) =>
              _AlternativeModalSheetSurface(
            backgroundColor: backgroundColor,
            cornerRadius: cornerRadius,
            elevation: elevation,
            showDragHandle: showDragHandle,
            dragHandleColor: dragHandleColor,
            morphStartExtent: morphStartExtent,
            child: sheetChild,
          ),
        );
}

class _AlternativeModalSheetSurface extends StatelessWidget {
  const _AlternativeModalSheetSurface({
    required this.child,
    required this.backgroundColor,
    required this.cornerRadius,
    required this.elevation,
    required this.showDragHandle,
    required this.dragHandleColor,
    required this.morphStartExtent,
  });

  static const double _handleTop = 10;
  static const double _handleHeight = 4;
  static const double _compactContentTop = 26;

  final Widget child;
  final Color? backgroundColor;
  final double cornerRadius;
  final double elevation;
  final bool showDragHandle;
  final Color? dragHandleColor;
  final double morphStartExtent;

  @override
  Widget build(BuildContext context) {
    final sheetController = Sheet.of(context)!.controller;

    return AnimatedBuilder(
      animation: sheetController.animation,
      builder: (context, _) {
        final extent = sheetController.animation.value;
        final pageProgress =
            ((extent - morphStartExtent) / (1 - morphStartExtent))
                .clamp(0.0, 1.0)
                .toDouble();
        final compactProgress = 1 - pageProgress;
        final effectiveRadius = cornerRadius * compactProgress;
        final effectiveElevation = elevation * compactProgress;

        return Material(
          color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          elevation: effectiveElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(effectiveRadius),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned.fill(
                child: SheetMediaQuery(
                  child: SafeArea(
                    top: true,
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: showDragHandle
                            ? _compactContentTop * compactProgress
                            : 0,
                      ),
                      child: ScrollConfiguration(
                        behavior: const _AlwaysScrollableSheetScrollBehavior(),
                        child: child,
                      ),
                    ),
                  ),
                ),
              ),
              if (showDragHandle)
                Positioned(
                  top: _handleTop,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    child: Opacity(
                      opacity: compactProgress,
                      child: Center(
                        child: Container(
                          width: 40,
                          height: _handleHeight,
                          decoration: BoxDecoration(
                            color: dragHandleColor ??
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _AlwaysScrollableSheetScrollBehavior extends MaterialScrollBehavior {
  const _AlwaysScrollableSheetScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics());
}
