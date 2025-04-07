import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  bool _showCurrentPassword = false;
  bool _showNewPassword = false;
  bool _showRepeatPassword = false;

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),

                      _buildStaticHeader(),
                      const SizedBox(height: 32),

                      // Obecne hasło
                      _buildPasswordField(
                        controller: _currentPasswordController,
                        label: 'Obecne hasło',
                        isVisible: _showCurrentPassword,
                        toggleVisibility: () {
                          setState(() {
                            _showCurrentPassword = !_showCurrentPassword;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Nowe hasło
                      _buildPasswordField(
                        controller: _newPasswordController,
                        label: 'Nowe hasło',
                        isVisible: _showNewPassword,
                        toggleVisibility: () {
                          setState(() {
                            _showNewPassword = !_showNewPassword;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // Powtórz nowe hasło
                      _buildPasswordField(
                        controller: _repeatPasswordController,
                        label: 'Powtórz nowe hasło',
                        isVisible: _showRepeatPassword,
                        toggleVisibility: () {
                          setState(() {
                            _showRepeatPassword = !_showRepeatPassword;
                          });
                        },
                      ),
                      const SizedBox(height: 32),

                      // Zapisz
                      SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                          ),
                          icon: const Icon(Icons.lock_reset),
                          label: const Text('Zapisz'),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Anuluj
                      SizedBox(
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: AppColors.primary,
                          ),
                          label: const Text('Anuluj'),
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

  Widget _buildStaticHeader() {
    return Column(
      children: [
        const Icon(Icons.lock, size: 150, color: AppColors.primary),
        const SizedBox(height: 12),
        Text(
          'Zmień hasło',
          style: AppTextStyles.heading.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          'Wprowadź aktualne i nowe hasło',
          style: AppTextStyles.subheading.copyWith(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isVisible,
    required VoidCallback toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        suffixIcon: IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }
}
