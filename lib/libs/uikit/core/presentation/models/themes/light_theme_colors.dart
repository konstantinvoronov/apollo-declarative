import 'ui_theme_colors.dart';
import 'package:flutter/material.dart';

class LightThemeColors extends AppThemeColors {
  const LightThemeColors()
      : super(
          bgPrimary: const Color(0xFFFFFFFF),
          bgPrimaryInverse: const Color(0xFF0F172A), //0xFF1F2937

          bgSecondary: const Color(0xFFF4F7FC),
          bgThird: const Color(0xFFEAF2FF),

          textPrimary: const Color(0xFF0F172A), //0xff1A1A1A
          textPrimaryInverse: const Color(0xFFFFFFFF),
          textSecondary: const Color(0xFF53627A),

          buttonPrimaryDefault: const Color(0xFF2563EB),
          buttonPrimaryActive: const Color(0xFF1D4ED8),
          buttonPrimaryDisabled: const Color(0xFFDCE5F3),
          buttonSecondaryDefault: const Color(0xFFE0ECFF),
          buttonSemiTransparen: const Color(0x142563EB),

          iconPrimaryActive: const Color(0xFF1D4ED8),
          iconAccent: const Color(0xFFF97316),//const Color(0xFFD4373A),
          iconSecondary: const Color(0xFF2563EB),
          iconPrimaryDefault: const Color(0xFF334155),
          iconSecondaryInverse: const Color(0xFFF8FAFC),
          iconPrimaryDisabled: const Color(0xFF94A3B8),

          redPrimary: const Color(0xFFDC2626),
          shadow: const Color(0x140F172A),
          fieldPrimary: const Color(0xFF64748B),
          accentPositive: const Color(0xFF15803D),
          accentAlert: const Color(0xFFDC2626),//const Color(0xFFd4373a),
          accentMedium: const Color(0xFFB45309),
          greyGradient: const LinearGradient(
                  colors: [Color(0xFFF4F7FC), Color(0xFFE0ECFF)],
          ),
        );
}
