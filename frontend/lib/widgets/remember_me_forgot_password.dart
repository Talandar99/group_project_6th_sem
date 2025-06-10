import 'package:flutter/material.dart';
import 'package:frontend/widgets/custom_snackbar.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class RememberMeForgotPassword extends StatefulWidget {
  final bool rememberMe;
  final ValueChanged<bool?> onChanged;

  const RememberMeForgotPassword({
    super.key,
    required this.rememberMe,
    required this.onChanged,
  });

  @override
  State<RememberMeForgotPassword> createState() =>
      _RememberMeForgotPasswordState();
}

class _RememberMeForgotPasswordState extends State<RememberMeForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: widget.rememberMe,
              onChanged: widget.onChanged,
              activeColor: AppColors.primary,
            ),
            Text('Zapamiętaj mnie', style: AppTextStyles.body),
          ],
        ),
        TextButton(
          onPressed: () {
            showCustomSnackBar(
              context,
              "To bardzo przykre",
              duration: Duration(seconds: 2),
            );
          },
          child: Text('Zapomniałeś hasła?', style: AppTextStyles.link),
        ),
      ],
    );
  }
}
