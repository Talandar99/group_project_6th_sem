import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextFieldWithLabelAndIcon extends StatelessWidget {
  final TextEditingController controller;
  final String textLabel;
  final IconData icon;

  const CustomTextFieldWithLabelAndIcon({
    super.key,
    required this.controller,
    required this.textLabel,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.iconColor),
        labelText: textLabel,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
