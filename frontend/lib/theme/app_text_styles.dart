import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.iconColor,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w200,
    color: AppColors.iconColor,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.iconColor,
  );

  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle appBarTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.iconColor,
  );

  static const TextStyle hint = TextStyle(
    fontSize: 14,
    color: Color(0xffDDDADA),
  );

  static const TextStyle logoText = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
    fontSize: 28,
    color: AppColors.primary,
    letterSpacing: 1.2,
  );

  static const TextStyle paymentAmount = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle paymentButton = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle paymentCancel = TextStyle(
    color: Colors.black54,
    fontSize: 16,
  );

  static const TextStyle paymentLabel = TextStyle(
    fontSize: 20,
    color: Colors.black54,
  );
}

