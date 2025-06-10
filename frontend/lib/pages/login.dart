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

//  Future<void> registerTest() async {
//    var x = await loginConnectionService.register(
//      EmailPasswordDto(
//        email: "user@example.com",
//        password: "securepassword123",
//      ),
//    );
//    print("=========================================");
//    print("status code");
//    print("-----------------------------------------");
//    print(x);
//    print("=========================================");
//    setState(() {
//      text = "This is register status code:";
//      token = x.toString();
//    });
//  }
//
//  Future<void> loginTest() async {
//    var x = await loginConnectionService.login(
//      EmailPasswordDto(
//        email: "user@example.com",
//        password: "securepassword123",
//      ),
//    );
//    print("=========================================");
//    print("token");
//    print("-----------------------------------------");
//    print(x.token);
//    print("=========================================");
//    setState(() {
//      text = "This is your token:";
//      token = x.token;
//    });
//  }
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final UserConnection loginConnectionService = GetIt.I<UserConnection>();
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedData();
  }

  Future<void> _loadRememberedData() async {
    final savedEmail = await persistentStorage.getData(StorageKeys.userEmail);
    final savedPassword = await persistentStorage.getData(StorageKeys.userPassword);

    if (savedEmail != null && savedPassword != null) {
      setState(() {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        rememberMe = true;
      });
    }
  }

  Future<void> _handleLogin(BuildContext context) async {
    try {
      final email = emailController.text;
      final password = passwordController.text;

      if (rememberMe) {
        await persistentStorage.saveData(StorageKeys.userEmail, email);
        await persistentStorage.saveData(StorageKeys.userPassword, password);
      } else {
        await persistentStorage.removeData(StorageKeys.userEmail);
        await persistentStorage.removeData(StorageKeys.userPassword);
      }

      var message = await loginConnectionService.login(
        EmailPasswordDto(email: email, password: password),
      );
      displaySnackbar(context, message);
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    } catch (e) {
      displaySnackbar(context, "Logowanie Nie Powiodło się");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Logowanie',
        onBackTap: () => Navigator.pop(context),
        showActions: false,
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
                        subtitle: 'Zaloguj się na swoje konto, aby móc w pełni korzystać z aplikacji.',
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
                                  isPassword: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: RememberMeForgotPassword(
                                  rememberMe: rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      rememberMe = value ?? false;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: CustomButton(
                                  text: 'Zaloguj się',
                                  onPressed: () => _handleLogin(context),
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
