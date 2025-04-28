import 'package:flutter/material.dart';
import 'package:frontend/widgets/cancel_button.dart';
import 'package:frontend/widgets/static_header.dart';
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
  final _nameController = TextEditingController(text: 'imie');
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
                vertical: 58,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: StaticHeader(
                            icon: Icons.person,
                            title: 'Zaktualizuj swój profil',
                            subtitle:
                                'Zmień swoje dane poniżej i kliknij "Zapisz", aby je zaktualizować.',
                            isCircleAvatar: true,
                          ),
                        ),

                        // Pole "Imię"
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
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
                        ),

                        // Pole "Email"
                        Padding(
                          padding: const EdgeInsets.only(bottom: 32),
                          child: TextFormField(
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
                        ),

                        // Zapisz
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: SizedBox(
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
            ),
          );
        },
      ),
    );
  }
}
