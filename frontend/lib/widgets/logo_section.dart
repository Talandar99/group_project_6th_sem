import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class LogoSection extends StatelessWidget {
  final String title;
  final String subtitle;

  const LogoSection({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.android, size: 100, color: AppColors.primary),
        Text(title, style: AppTextStyles.heading),
        const SizedBox(height: 8),
        Text(subtitle, style: AppTextStyles.subheading),
      ],
    );
  }
}
