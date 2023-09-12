import 'package:flutter/material.dart';
import 'package:news/common/app_theme/app_colors.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
