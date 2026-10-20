import '../../../../../../app/di.dart';
import '../../../../../../app/routing/app_router.dart';
import 'app_shadows.dart';
import 'dark_theme_colors.dart';
import 'light_theme_colors.dart';
import 'ui_text_styles.dart';
import 'package:flutter/material.dart';

import 'app_theme_extension.dart';
/// use final theme = AppTheme.of(context);
class AppTheme {
  static const _lightThemeColors = LightThemeColors();
  static const _darkThemeColors = DarkThemeColors();

  /// theme верент глоальный контекст и все будет ок, но! не вызовет ребилда при смене там где есть контекст лучше использовать AppTheme.of(context)
  static AppThemeExtension get theme {
    return Theme.of(di<AppRouter>().rootNavigatorKey.currentContext!).extension<AppThemeExtension>()!;
  }

  static AppThemeExtension of(BuildContext context) => Theme.of(context).extension<AppThemeExtension>()!;

  static final _lightThemeExtension = AppThemeExtension(
    colors: _lightThemeColors,
    textStyles: AppTextStyles(_lightThemeColors.textPrimary),
    shadows: AppShadows(_lightThemeColors.shadow),
  );
  static final _darkThemeExtension = AppThemeExtension(
    colors: _darkThemeColors,
    textStyles: AppTextStyles(_darkThemeColors.textPrimary),
    shadows: AppShadows(_darkThemeColors.shadow),
  );

  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: _lightThemeColors.buttonPrimaryDefault,
      secondary: _lightThemeColors.iconSecondary,
      surface: _lightThemeColors.bgPrimary,
      onPrimary: _lightThemeColors.textPrimaryInverse,
      onSurface: _lightThemeColors.textPrimary,
      error: _lightThemeColors.redPrimary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(backgroundColor: Colors.transparent),
    ),
    extensions: <ThemeExtension<AppThemeExtension>>[_lightThemeExtension],
    scaffoldBackgroundColor: _lightThemeColors.bgPrimary,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: _darkThemeColors.buttonPrimaryDefault,
      secondary: _darkThemeColors.iconSecondary,
      surface: _darkThemeColors.bgPrimary,
      onPrimary: _darkThemeColors.textPrimaryInverse,
      onSurface: _darkThemeColors.textPrimary,
      error: _darkThemeColors.redPrimary,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
    ),
    extensions: <ThemeExtension<AppThemeExtension>>[_darkThemeExtension],
    scaffoldBackgroundColor: _darkThemeColors.bgPrimary,
  );
}
