import 'package:flutter/material.dart';
import 'package:frontend/pages/home.dart';
import 'package:frontend/services/login_connection.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:frontend/web_api/dto/email_password.dart';
import 'package:frontend/widgets/custom_snackbar.dart';
import 'package:get_it/get_it.dart';
import '../theme/app_colors.dart';
import '../widgets/logo_section.dart';
import '../widgets/custom_text_field_with_label_and_icon.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_app_bar.dart';

class Register extends StatelessWidget {
  Register({super.key});

  final UserConnection loginConnectionService = GetIt.I<UserConnection>();
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Rejestracja'),
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
                        title: 'Załóż konto!',
                        subtitle:
                            'Załóż swoje konto, aby móc w pełni korzystać z aplikacji.',
                      ),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: CustomTextFieldWithLabelAndIcon(
                                  controller: emailController,
                                  textLabel: "Email",
                                  icon: Icons.email,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: CustomTextFieldWithLabelAndIcon(
                                  controller: passwordController,
                                  textLabel: "Hasło",
                                  icon: Icons.lock,
                                  isPassword: true,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 16),
                                child: CustomButton(
                                  text: 'Załóż konto',
                                  onPressed: () async {
                                    try {
                                      var message = await loginConnectionService
                                          .register(
                                            EmailPasswordDto(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            ),
                                          );
                                      showCustomSnackBar(context, message);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomePage(),
                                        ),
                                      );
                                    } catch (e) {
                                      showCustomSnackBar(
                                        context,
                                        "Rejestracja nie powiodła się",
                                      );
                                    }
                                  },
                                ),
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
