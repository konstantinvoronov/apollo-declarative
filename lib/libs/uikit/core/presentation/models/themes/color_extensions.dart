import 'package:flutter/material.dart';

extension ColorExt on Color {
  ColorFilter get toFilter {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}
