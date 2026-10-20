import 'package:flutter/material.dart';

class AppShadows {
  const AppShadows(this.color);

  final Color color;

  List<BoxShadow>? navBarShadow() => [
        BoxShadow(
          color: color.withOpacity(0.0456),
          blurRadius: 10,
          offset: const Offset(0, 8),
        ),
        BoxShadow(
          color: color.withOpacity(0.07),
          blurRadius: 38,
          offset: const Offset(0, 28),
        ),
      ];

  List<BoxShadow>? emptyListImageShadow() => [
        BoxShadow(
          color: color.withOpacity(0.05),
          blurRadius: 25,
          offset: const Offset(0, 1),
        ),
      ];

  AppShadows lerp(AppShadows? other, double t) {
    if (other is! AppShadows) {
      return this;
    }
    return AppShadows(
      Color.lerp(color, other.color, t) ?? color,
    );
  }
}
