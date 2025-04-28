import 'package:flutter/material.dart';
import 'package:frontend/widgets/cancel_button.dart';
import 'package:frontend/widgets/static_header.dart';
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
                vertical: 48,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 38),
                        child: StaticHeader(
                          icon: Icons.lock,
                          title: 'Zmień hasło',
                          subtitle: 'Wprowadź aktualne i nowe hasło',
                        ),
                      ),

                      // Obecne hasło
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildPasswordField(
                          controller: _currentPasswordController,
                          label: 'Obecne hasło',
                          isVisible: _showCurrentPassword,
                          toggleVisibility: () {
                            setState(() {
                              _showCurrentPassword = !_showCurrentPassword;
                            });
                          },
                        ),
                      ),

                      // Nowe hasło
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildPasswordField(
                          controller: _newPasswordController,
                          label: 'Nowe hasło',
                          isVisible: _showNewPassword,
                          toggleVisibility: () {
                            setState(() {
                              _showNewPassword = !_showNewPassword;
                            });
                          },
                        ),
                      ),

                      // Powtórz nowe hasło
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: _buildPasswordField(
                          controller: _repeatPasswordController,
                          label: 'Powtórz nowe hasło',
                          isVisible: _showRepeatPassword,
                          toggleVisibility: () {
                            setState(() {
                              _showRepeatPassword = !_showRepeatPassword;
                            });
                          },
                        ),
                      ),

                      // Zapisz
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
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
                      ),

                      // Anuluj
                      CancelButton(
                        onPressed: () {
                          Navigator.pop(context);
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
