import 'dart:math' as math;
import 'package:flutter/widgets.dart';

class AppTextScaler extends TextScaler {
  final double s;                 // your uniform UI scale (e.g., min(sx, sy))
  final bool respectSystem;       // include system text scale?
  final double systemFactor;      // e.g., MediaQuery.textScaler.scale(1.0)
  final double minFactor;         // clamp low
  final double maxFactor;         // clamp high

  const AppTextScaler({
    required this.s,
    this.respectSystem = true,
    this.systemFactor = 1.0,
    this.minFactor = 0.2,
    this.maxFactor = 1.25,
  });

  double get _factor {
    final f = s * (respectSystem ? systemFactor : 1.0);
    return f.clamp(minFactor, maxFactor);
  }

  @override
  double scale(double fontSize) => fontSize * _factor;

  @override
  double get textScaleFactor => _factor;
}
