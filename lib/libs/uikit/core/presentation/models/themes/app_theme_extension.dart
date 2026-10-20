import 'app_shadows.dart';
import 'ui_text_styles.dart';
import 'ui_theme_colors.dart';
import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.colors,
    required this.textStyles,
    required this.shadows,
  });

  final AppThemeColors colors;
  final AppTextStyles textStyles;
  final AppShadows shadows;

  @override
  AppThemeExtension copyWith({
    AppThemeColors? colors,
    AppTextStyles? textStyles,
    AppShadows? shadows,
  }) {
    return AppThemeExtension(
      colors: colors ?? this.colors,
      textStyles: textStyles ?? this.textStyles,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  AppThemeExtension lerp(AppThemeExtension? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }
    return AppThemeExtension(
      colors: colors.lerp(other.colors, t),
      textStyles: textStyles.lerp(other.textStyles, t),
      shadows: shadows.lerp(other.shadows, t),
    );
  }
}
