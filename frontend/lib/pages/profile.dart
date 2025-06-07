import 'package:flutter/material.dart';
import 'package:frontend/pages/edit_profile_page.dart';
import 'package:frontend/widgets/cancel_button.dart';
import 'change_password_page.dart';
import 'login.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/profile_action_button.dart';
import '../widgets/profile_card.dart';
import 'home.dart';
import '../widgets/custom_app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(
        title: 'Mój profil',
        onBackTap: () {
          Navigator.pop(context);
        },
        showActions: false,
      ),
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
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Karta Profilu
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: ProfileCard(
                          name: 'MyName',
                          email: 'myemail@example.com',
                        ),
                      ),
                      ProfileActionButton(
                        text: 'Edytuj Profil',
                        icon: Icons.edit,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfilePage(),
                            ),
                          );
                        },
                      ),
                      ProfileActionButton(
                        text: 'Zmień Hasło',
                        icon: Icons.lock,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangePasswordPage(),
                            ),
                          );
                        },
                        outlined: true,
                      ),
                      ProfileActionButton(
                        text: 'Wyloguj się',
                        icon: Icons.logout,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      // Mozna rozwayzc usunięcia tego przycisku bo u gory jest nawigacja z cofaniem albo wywalic cofanie z nawigacji w tym widoku
                      CancelButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
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
