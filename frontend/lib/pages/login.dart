import 'package:flutter/material.dart';
import 'package:frontend/pages/home.dart';
import 'package:frontend/widgets/custom_snackbar.dart';
import 'package:get_it/get_it.dart';
import '../services/login_connection.dart';
import '../services/persistant_storage.dart';
import '../theme/app_colors.dart';
import '../web_api/dto/email_password.dart';
import '../widgets/logo_section.dart';
import '../widgets/custom_text_field_with_label_and_icon.dart';
import '../widgets/remember_me_forgot_password.dart';
import '../widgets/custom_button.dart';
import '../widgets/create_account_button.dart';
import '../widgets/custom_app_bar.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final UserConnection loginConnectionService = GetIt.I<UserConnection>();
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Logowanie',
        showAboutUs: false,
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
                                child: CustomTextFieldWithLabelAndIcon(
                                  controller: emailController,
                                  textLabel: "Email",
                                  icon: Icons.email,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: CustomTextFieldWithLabelAndIcon(
                                  controller: passwordController,
                                  textLabel: "Hasło",
                                  icon: Icons.lock,
                                  isPassword:
                                      true, // dodaje zeby sie tam to oczko pokazalo
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: RememberMeForgotPassword(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomButton(
                                  text: 'Zaloguj się',
                                  onPressed: () async {
                                    try {
                                      var message = await loginConnectionService
                                          .login(
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
                                        "Logowanie Nie Powiodło się",
                                      );
                                    }
                                    // Login here and navigate to the home page
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
