import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class StaticHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isCircleAvatar;

  const StaticHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.isCircleAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isCircleAvatar
            ? CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primary,
              child: Icon(icon, size: 60, color: Colors.white),
            )
            : Icon(icon, size: 150, color: AppColors.primary),
        const SizedBox(height: 12),
        Text(
          title,
          style: AppTextStyles.heading.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: AppTextStyles.subheading.copyWith(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
