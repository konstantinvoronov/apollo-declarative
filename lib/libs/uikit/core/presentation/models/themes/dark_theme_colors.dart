import 'ui_theme_colors.dart';
import 'package:flutter/material.dart';

class DarkThemeColors extends AppThemeColors {
  const DarkThemeColors()
      : super(
          bgPrimary: const Color(0xFF101827),
          bgPrimaryInverse: const Color(0xFFFFFFFF), //0xFF1F2937

          bgSecondary: const Color(0xFF1B2738), //1e1f26 -> iconPrimaryActive
          bgThird: const Color(0xFF24334B),

          textPrimary: const Color(0xFFF8FAFC), //0xff1A1A1A
          textPrimaryInverse: const Color(0xFF0F172A),
          textSecondary: const Color(0xFFB4C4D8),

          buttonPrimaryDefault: const Color(0xFF60A5FA),
          buttonPrimaryActive: const Color(0xFF93C5FD),
          buttonPrimaryDisabled: const Color(0xFF334155),
          buttonSecondaryDefault: const Color(0xFF193B68),
          buttonSemiTransparen: const Color(0x1960A5FA),

          iconPrimaryActive: const Color(0xFF93C5FD),
          iconAccent: const Color(0xFFFDBA74),//const Color(0xFFD4373A),
          iconSecondary: const Color(0xFF67E8F9),
          iconPrimaryDefault: const Color(0xFFDCE8F8),
          iconPrimaryDisabled: const Color(0xFF64748B),
          iconSecondaryInverse: const Color(0xFF0F172A),

          redPrimary: const Color(0xFFFCA5A5),
          shadow: const Color(0x66000000),
          fieldPrimary: const Color(0xFFB4C4D8),
          accentPositive: const Color(0xFF86EFAC),
          accentAlert: const Color(0xFFFCA5A5),//const Color(0xFFd4373a),
          accentMedium: const Color(0xFFFDE68A),
          greyGradient: const LinearGradient(
                  colors: [Color(0xFF1B2738), Color(0xFF24334B)],
          ),
  );
}
