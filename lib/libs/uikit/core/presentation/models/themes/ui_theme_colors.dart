import 'package:flutter/material.dart';

class AppThemeColors {
  const AppThemeColors({
    required this.bgPrimary,
    required this.bgPrimaryInverse,
    required this.bgSecondary,
    required this.iconPrimaryDisabled,
    required this.bgThird,
    required this.textPrimary,
    required this.textPrimaryInverse,
    required this.textSecondary,
    required this.iconPrimaryDefault,
    required this.iconPrimaryActive,
    required this.iconAccent,
    required this.buttonPrimaryDefault,
    required this.buttonPrimaryActive,
    required this.buttonPrimaryDisabled,
    required this.iconSecondary,
    required this.iconSecondaryInverse,
    required this.redPrimary,
    required this.shadow,
    required this.fieldPrimary,
    required this.accentPositive,
    required this.accentAlert,
    required this.accentMedium,
    required this.buttonSecondaryDefault,
    required this.greyGradient, required this.buttonSemiTransparen,
  });

  //0xfff6f6f6
  final Color bgPrimary;
  /// light - 0xffffffff
  final Color bgSecondary;
  final Color bgThird;
  final Color bgPrimaryInverse;

  /// light - 0xff1A1A1A
  final Color textPrimary;
  final Color textPrimaryInverse;

  /// light - #A1A1A1
  final Color textSecondary;
  final Color iconPrimaryDefault;
  final Color iconPrimaryDisabled;
  final Color iconPrimaryActive;
  final Color iconAccent;
  final Color buttonPrimaryDefault;
  final Color buttonPrimaryActive;
  final Color buttonPrimaryDisabled;
  final Color buttonSemiTransparen;
  final Color iconSecondary;
  final Color iconSecondaryInverse;
  final Color redPrimary;
  final Color shadow;
  final Color fieldPrimary;
  final Color accentPositive;
  final Color accentAlert;
  final Color accentMedium;
  final Color buttonSecondaryDefault;
  final LinearGradient greyGradient;

  AppThemeColors lerp(AppThemeColors? other, double t) {
    if (other is! AppThemeColors) {
      return this;
    }
    return AppThemeColors(
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t) ?? bgPrimary,
      bgPrimaryInverse: Color.lerp(bgPrimaryInverse, other.bgPrimaryInverse, t) ?? bgPrimaryInverse,
      bgSecondary: Color.lerp(bgSecondary, other.bgSecondary, t) ?? bgSecondary,
      bgThird: Color.lerp(bgThird, other.bgThird, t) ?? bgThird,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textPrimaryInverse:
          Color.lerp(textPrimaryInverse, other.textPrimaryInverse, t) ?? textPrimaryInverse,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      iconPrimaryDefault:
          Color.lerp(iconPrimaryDefault, other.iconPrimaryDefault, t) ?? iconPrimaryDefault,
      iconPrimaryActive:
          Color.lerp(iconPrimaryActive, other.iconPrimaryActive, t) ?? iconPrimaryActive,
      iconAccent: Color.lerp(iconAccent, other.iconAccent, t) ?? iconAccent,
      buttonPrimaryDefault:
          Color.lerp(buttonPrimaryDefault, other.buttonPrimaryDefault, t) ?? buttonPrimaryDefault,
      buttonPrimaryActive:
          Color.lerp(buttonPrimaryActive, other.buttonPrimaryActive, t) ?? buttonPrimaryActive,
      buttonPrimaryDisabled:
        Color.lerp(buttonPrimaryDisabled, other.buttonPrimaryDisabled, t) ?? buttonPrimaryDisabled,
      iconSecondary: Color.lerp(iconSecondary, other.iconSecondary, t) ?? iconSecondary,
      iconPrimaryDisabled: Color.lerp(iconPrimaryDisabled, other.iconPrimaryDisabled, t) ?? iconPrimaryDisabled,

      iconSecondaryInverse:
          Color.lerp(iconSecondaryInverse, other.iconSecondaryInverse, t) ?? iconSecondaryInverse,
      redPrimary: Color.lerp(redPrimary, other.redPrimary, t) ?? redPrimary,
      shadow: Color.lerp(shadow, other.shadow, t) ?? shadow,
      fieldPrimary: Color.lerp(fieldPrimary, other.fieldPrimary, t) ?? fieldPrimary,
      accentPositive: Color.lerp(accentPositive, other.accentPositive, t) ?? accentPositive,
      accentAlert: Color.lerp(accentAlert, other.accentAlert, t) ?? accentAlert,
      accentMedium: Color.lerp(accentMedium, other.accentMedium, t) ?? accentMedium,
      buttonSecondaryDefault: Color.lerp(buttonSecondaryDefault, other.buttonSecondaryDefault, t) ??
          buttonSecondaryDefault,
      buttonSemiTransparen: Color.lerp(buttonSemiTransparen, other.buttonSemiTransparen, t) ??
          buttonSemiTransparen,
      greyGradient: greyGradient,
    );
  }
}
