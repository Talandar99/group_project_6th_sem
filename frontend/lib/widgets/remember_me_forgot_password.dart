import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class RememberMeForgotPassword extends StatelessWidget {
  const RememberMeForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Remember me
        Row(
          children: [
            Checkbox(
              value: false,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
            Text('Zapamiętaj mnie', style: AppTextStyles.body),
          ],
        ),

        //Forgot password
        TextButton(
          onPressed: () {},
          child: Text('Zapomniałeś hasła?', style: AppTextStyles.link),
        ),
      ],
    );
  }
}
