import '../../models/layout/app_sizes.dart';
import '../../models/themes/app_theme.dart';
import 'package:flutter/material.dart';

const unlimitedLines = 100;

extension StringTextExtensions on String {

  Widget h0({ Key? key, Color? color, TextAlign? textAlign, int? maxLines }) {
    return TextOverflowed(this,key: key,
      textStyle: AppTheme.theme.textStyles.h0(color: color),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,
    );
  }

  Widget superBig0({ Key? key, Color? color, TextAlign? textAlign, int? maxLines }) {
    return TextOverflowed(this,key: key,
      textStyle: AppTheme.theme.textStyles.superBig0(color: color),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,
    );
  }

  Widget superBig1({ Key? key, Color? color, TextAlign? textAlign, int? maxLines }) {
    return TextOverflowed(this,key: key,
      textStyle: AppTheme.theme.textStyles.superBig1(color: color),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,
    );
  }

  Widget superBig2({ Key? key, Color? color, TextAlign? textAlign, int? maxLines }) {
    return TextOverflowed(this,key: key,
      textStyle: AppTheme.theme.textStyles.superBig2(color: color),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,
    );
  }

  Widget h1({ Key? key, Color? color, TextAlign? textAlign, int? maxLines }) {
    return TextOverflowed(this,key: key,
      textStyle: AppTheme.theme.textStyles.h1(color: color),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,
    );
  }

  Widget h2({ Key? key, Color? color, TextAlign? textAlign, int? maxLines }) {
    return TextOverflowed(this,key: key,
      textStyle: AppTheme.theme.textStyles.h2(color: color),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,
    );
  }

  Widget h3({ Key? key, Color? color, TextAlign? textAlign, int? maxLines }) {
    return TextOverflowed(this,key: key,
      textStyle: AppTheme.theme.textStyles.h3(color: color),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,
    );
  }


  Widget p1({ Key? key, Color? color, TextAlign? textAlign , int? maxLines }) {
    return TextOverflowed(this,key:key, textStyle: AppTheme.theme.textStyles.p1(color: color),
    textAlign: textAlign ?? TextAlign.left,
    maxLines: maxLines ?? 1,);
  }

  Widget p2({ Color? color, TextAlign? textAlign , int? maxLines,FontWeight? fontWeight }) {
    return TextOverflowed(this, textStyle: AppTheme.theme.textStyles.p2(color: color),
      textAlign: textAlign ?? TextAlign.left,fontWeight:fontWeight,
      maxLines: maxLines ?? 1,);
  }

  Widget p3({ Color? color, TextAlign? textAlign , int? maxLines,FontWeight? fontWeight }) {
    return TextOverflowed(this, textStyle: AppTheme.theme.textStyles.p3(color: color,fontWeight: fontWeight),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,);
  }

  Widget p4({ Color? color, TextAlign? textAlign , int? maxLines }) {
    return TextOverflowed(this, textStyle: AppTheme.theme.textStyles.p4(color: color),
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines ?? 1,);
  }

}

class TextOverflowed extends StatelessWidget {
  final TextStyle? textStyle;
  final String text;
  final int maxLines;
  final TextAlign textAlign;
  final FontWeight? fontWeight;

  const TextOverflowed(this.text, {Key? key, this.textStyle, this.maxLines = 2, this.textAlign = TextAlign.left,this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appSizes = AppSizes.of(context);

    return Text(
      text,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textScaler: appSizes.appTextScaler,
      style: textStyle?.copyWith(fontWeight: fontWeight),
      textAlign: textAlign,
    );
  }
}

