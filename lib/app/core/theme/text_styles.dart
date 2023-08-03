import 'package:flutter/material.dart';

import 'app_colors.dart';

class TextStyles {
  TextStyles({this.context});

  BuildContext? context;

  TextStyle homeTitle() => TextStyle(
    fontSize: 24,
    color: AppColors.white,
    fontWeight: FontWeight.w500);

  TextStyle homeSubtitle() => TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold);

  TextStyle homeSubtitleText() => TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.normal);

  final TextStyle hint = TextStyle(
      fontSize: 14,
      color: Colors.white,
      fontWeight: FontWeight.w500);

}