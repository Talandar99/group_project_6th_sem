import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/pages/home.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/logo_section.dart';
import '../widgets/email_field.dart';
import '../widgets/password_field.dart';
import '../widgets/remember_me_forgot_password.dart';
import '../widgets/custom_button.dart';
import '../widgets/create_account_button.dart';
import '../widgets/custom_app_bar.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Logowanie',
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      backgroundColor: AppColors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? constraints.maxWidth * 0.2 : 24,
                vertical: 24,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(
                    children: [
                      const LogoSection(
                        title: 'Witaj ponownie!',
                        subtitle:
                            'Zaloguj się na swoje konto, aby móc w pełni korzystać z aplikacji.',
                      ),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: EmailField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: PasswordField(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: RememberMeForgotPassword(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomButton(
                                  text: 'Zaloguj się',
                                  onPressed: () {
                                    // Login here and navigate to the home page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CreateAccountButton(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
