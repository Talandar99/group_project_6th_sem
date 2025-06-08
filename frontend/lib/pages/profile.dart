import 'package:flutter/material.dart';
import 'package:frontend/pages/edit_profile_page.dart';
import 'package:frontend/services/persistant_storage.dart';
import 'package:frontend/widgets/cancel_button.dart';
import 'package:get_it/get_it.dart';
import 'change_password_page.dart';
import '../theme/app_colors.dart';
import '../widgets/profile_action_button.dart';
import '../widgets/profile_card.dart';
import 'home.dart';
import '../widgets/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final PersistentStorage persistentStorage = GetIt.I<PersistentStorage>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppBar(title: 'Mój profil', showActions: false),
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
                      FutureBuilder<String>(
                        future: persistentStorage.getData(
                          StorageKeys.userEmail,
                        ),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                            default:
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: ProfileCard(email: snapshot.data!),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 32),
                                  child: ProfileCard(email: '......'),
                                );
                              }
                          }
                        },
                      ),
                      // Karta Profilu
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
                          setState(() {
                            persistentStorage.saveData(
                              StorageKeys.apiToken,
                              "",
                            );
                          });
                          //                          Navigator.pop(context);
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
