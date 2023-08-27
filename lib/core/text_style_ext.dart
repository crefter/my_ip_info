import 'package:flutter/material.dart';

extension TextStyleExt on TextTheme {
  TextStyle get header => const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
      );

  TextStyle get mainText => const TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
}
