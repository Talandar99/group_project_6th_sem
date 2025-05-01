import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CancelButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const CancelButton({
    super.key,
    required this.onPressed,
    this.label = 'Anuluj',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.cancel, color: AppColors.primary),
        label: Text(label),
      ),
    );
  }
}
