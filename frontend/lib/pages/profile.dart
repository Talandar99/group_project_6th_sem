import 'package:flutter/material.dart';
import 'package:frontend/pages/edit_profile_page.dart';
import 'change_password_page.dart';
import 'login.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_button.dart';
import 'home.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildStaticAppBar(),
                      const SizedBox(height: 16),
                      _buildProfileCard(),
                      const SizedBox(height: 32),
                      _buildButton(
                        'Edytuj Profil',
                        Icons.edit,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfilePage(),
                            ),
                          );
                        },
                      ),
                      _buildButton(
                        'Zmień Hasło',
                        Icons.lock,
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
                      _buildButton(
                        'Wyloguj się',
                        Icons.logout,
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                      _buildButton(
                        'Anuluj',
                        Icons.cancel,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        outlined: true,
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

  Widget _buildStaticAppBar() {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      alignment: Alignment.center,
      child: Text('Mój profil', style: AppTextStyles.appBarTitle),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text('MyName', style: AppTextStyles.heading),
            const SizedBox(height: 4),
            Text('myemail@example.com', style: AppTextStyles.subheading),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    IconData icon, {
    required VoidCallback onPressed,
    bool outlined = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child:
            outlined
                ? OutlinedButton.icon(
                  onPressed: onPressed,
                  icon: Icon(icon, color: AppColors.primary),
                  label: Text(text),
                )
                : ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: onPressed,
                  icon: Icon(icon, color: Colors.white),
                  label: Text(text),
                ),
      ),
    );
  }
}
