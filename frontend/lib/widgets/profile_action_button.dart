import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileActionButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final bool outlined;

  const ProfileActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child:
            outlined
                ? OutlinedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(icon, color: AppColors.primary),
                  label: Text(text),
                )
                : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: onPressed,
                  icon: Icon(icon, color: Colors.white),
                  label: Text(text),
                ),
      ),
    );
  }
}
