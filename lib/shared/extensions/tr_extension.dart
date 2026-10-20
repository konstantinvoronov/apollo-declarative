import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as translator;

extension StringExtension on String {
  String capitalizeFirstOfEach() {
    if (isEmpty) return '';
    return split(' ').map((str) => str.toUpperCase()).join(' ');
  }

  String trEx(BuildContext context) {
    if (isEmpty) return '';
    return translator.tr(this, context: context);
  }

  String tr({
    List<String>? args,
    Map<String, String>? namedArgs,
    String? gender,
  }) {
    if (isEmpty) return '';

    return translator.tr(
      this,
      args: args,
      namedArgs: namedArgs,
      gender: gender,
    );
  }
}
