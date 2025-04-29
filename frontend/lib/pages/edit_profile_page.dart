import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/custom_button.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'name');
  final _emailController = TextEditingController(text: 'email@xoxo.xoxo');

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 48),

                        _buildStaticHeader(),
                        const SizedBox(height: 32),

                        // Imię
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Imię',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Podaj swoje imię';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || !value.contains('@')) {
                              return 'Podaj poprawny email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),

                        // Zapisz
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pop(context);
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Zapisz'),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Anuluj
                        SizedBox(
                          width: double.infinity,
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
            ),
          );
        },
      ),
    );
  }

  Widget _buildStaticHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 60,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person, size: 60, color: Colors.white),
        ),
        const SizedBox(height: 12),
        Text(
          'Zaktualizuj swój profil',
          style: AppTextStyles.heading.copyWith(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          'Zmień swoje dane poniżej i kliknij "Zapisz", aby je zaktualizować.',
          style: AppTextStyles.subheading.copyWith(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
