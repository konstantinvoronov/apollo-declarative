import 'package:flutter/material.dart';

class AppTextStyles {
  const AppTextStyles(this.textColor);

  final Color textColor;

  static const _baseTextStyle =
  TextStyle(fontFamily: 'SuisseIntl',
      height: 1.2,
      wordSpacing: 1.0,
      letterSpacing: 1.0,
      leadingDistribution: TextLeadingDistribution.proportional);

//  static const _secondaryTextStyle = TextStyle(fontFamily: 'InterTight');


  TextStyle p1({Color? color}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.2,
  );

  TextStyle p2({Color? color,FontWeight? fontWeight}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 14,

    fontWeight: fontWeight ?? FontWeight.w400,
    height: 1.2,
  );

  TextStyle p3({Color? color,FontWeight? fontWeight}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 12,
    fontWeight: fontWeight ?? FontWeight.w400,
    height: 1.2,
  );

  TextStyle p4({Color? color}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 10,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );



  TextStyle h0({Color? color}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 48,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: -0.3,
  );

  TextStyle superBig2({Color? color}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 56,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: -0.3,
  );

  TextStyle superBig1({Color? color}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 64,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: -0.3,
  );

  TextStyle superBig0({Color? color}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 70,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: -0.3,
  );

  TextStyle h1({Color? color}) => _baseTextStyle.copyWith(
        color: color ?? textColor,
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1.2,
        letterSpacing: -0.3,
      );

  TextStyle h2({Color? color}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.0,
    letterSpacing: -0.3,
  );


  TextStyle h3({Color? color}) => _baseTextStyle.copyWith(
    color: color ?? textColor,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: 0.0,
  );

  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      Color.lerp(textColor, other.textColor, t) ?? textColor,
    );
  }
}
