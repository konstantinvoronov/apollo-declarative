import '../../../../../../app/config/app_conf.dart';
import '../../models/themes/app_theme.dart';
import 'package:flutter/material.dart';

import '../../models/themes/app_theme_extension.dart';

class _ButtonAnimationStyle {
  final Color defaultColor;
  final Color activeColor;

  _ButtonAnimationStyle({
    required this.defaultColor,
    required this.activeColor,
  });

  factory _ButtonAnimationStyle.fromTheme(
    AppThemeExtension theme, {
    Color? defaultColor,
    Color? activeColor,
  }) {
    return _ButtonAnimationStyle(
      defaultColor: defaultColor ?? theme.colors.iconPrimaryDefault,
      activeColor: activeColor ?? theme.colors.iconPrimaryActive,
    );
  }
}

class ButtonAnimation extends StatefulWidget {
  final Widget Function(Color) child;
  final VoidCallback? onTap;
  final Color? defaultColor;
  final Color? activeColor;

  const ButtonAnimation({
    super.key,
    required this.child,
    required this.onTap,
    this.defaultColor,
    this.activeColor,
  });

  @override
  State<ButtonAnimation> createState() => _State();
}

class _State extends State<ButtonAnimation> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<Color?>? _colorTween;
  bool _disposed = false;
  _ButtonAnimationStyle? _style;

  void _onTapDown() {
    _animationController?.value = 1.0;
  }

  Future<void> _onTapUp() async {
    while (_animationController?.isAnimating ?? false) {
      await Future.delayed(AppConf.durationDefault);
    }
    if (!_disposed) _animationController?.reverse();
  }

  @override
  void initState() {
    _setStyle();
    super.initState();
    _animationController = AnimationController(
      duration: AppConf.durationDefault,
      vsync: this,
    );
    _setColorTween();
    _animationController?.addListener(() => setState(() {}));
  }

  @override
  void didUpdateWidget(covariant ButtonAnimation oldWidget) {
    if (oldWidget.activeColor != widget.activeColor ||
        oldWidget.defaultColor != widget.defaultColor) {
      _setStyle();
      _setColorTween();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _setColorTween() {
    if (_style == null || _animationController == null) return;
    _colorTween = ColorTween(begin: _style!.defaultColor, end: _style!.activeColor)
        .animate(_animationController!);
  }

  void _setStyle() {
    _style = _ButtonAnimationStyle.fromTheme(
      AppTheme.theme,
      defaultColor: widget.defaultColor,
      activeColor: widget.activeColor,
    );
  }

  @override
  void dispose() {
    _disposed = true;
    _animationController?.stop();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (widget.onTap != null) ? (_) => _onTapDown() : null,
      onTapCancel: (widget.onTap != null) ? _onTapUp : null,
      onTapUp: (widget.onTap != null)
          ? (_) {
              _onTapUp();
              widget.onTap!.call();
            }
          : null,
      behavior: widget.onTap != null ? HitTestBehavior.opaque : HitTestBehavior.deferToChild,
      child: widget.child(
        _colorTween?.value ?? widget.defaultColor ?? AppTheme.theme.colors.iconPrimaryDefault,
      ),
    );
  }
}
