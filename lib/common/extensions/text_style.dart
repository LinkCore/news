import 'package:flutter/material.dart';

extension TextStyleExtension on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w900);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w600);

  TextStyle withColor(Color other) => copyWith(color: other);

  TextStyle get white => copyWith(color: Colors.white);
}
