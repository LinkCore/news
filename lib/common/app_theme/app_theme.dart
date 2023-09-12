import 'package:flutter/material.dart';
import 'package:news/common/app_theme/app_colors.dart';
import 'package:news/common/app_theme/text_theme.dart';

abstract class AppTheme {
  static ThemeData theme = ThemeData(
    textTheme: AppTextStyles.textTheme,
    colorScheme: const ColorScheme.light(primary: Color(0xFF191919)),
    extensions: <ThemeExtension<dynamic>>[
      AppColors(
        textDisabledColor: const Color.fromRGBO(217, 217, 217, 50),
      ),
    ],
  );
}
