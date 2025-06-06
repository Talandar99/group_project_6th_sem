import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextFieldWithLabelAndIcon extends StatefulWidget {
  final TextEditingController controller;
  final String textLabel;
  final IconData icon;
  final bool isPassword;

  const CustomTextFieldWithLabelAndIcon({
    super.key,
    required this.controller,
    required this.textLabel,
    required this.icon,
    this.isPassword = false,
  });

  @override
  State<CustomTextFieldWithLabelAndIcon> createState() => _CustomTextFieldWithLabelAndIconState();
}

class _CustomTextFieldWithLabelAndIconState extends State<CustomTextFieldWithLabelAndIcon> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.icon, color: AppColors.iconColor),
        labelText: widget.textLabel,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.iconColor,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
