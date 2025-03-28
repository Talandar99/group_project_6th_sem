import 'package:flutter/material.dart';
import 'package:frontend/pages/register.dart';
import '../theme/app_text_styles.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
        },
        child: Text('Załóż konto', style: AppTextStyles.link),
      ),
    );
  }
}
