import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  Color textDisabledColor;

  Color disabledColor(bool statement) =>
      statement ? textDisabledColor : Colors.black;

  @override
  AppColors lerp(AppColors? other, double t) => other ?? this;

  AppColors({
    required this.textDisabledColor,
  });

  AppColors copyWith({
    Color? textDisabledColor,
  }) {
    return AppColors(
      textDisabledColor: textDisabledColor ?? this.textDisabledColor,
    );
  }
}
