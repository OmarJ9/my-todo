import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_variables.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/features/settings/widgets/account_section.dart';
import 'package:todo_app/features/settings/widgets/buttons_section.dart';
import 'package:todo_app/features/settings/widgets/preferences_section.dart';
import 'package:todo_app/features/settings/widgets/profile_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _userController =
      TextEditingController(text: 'User');
  int selectedProfileImage = profileimagesindex;
  bool notificationsEnabled = false;
  ThemeMode selectedTheme = ThemeMode.system;
  bool isDarkModeEnabled = false;

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Settings',
          style: AppTypography.bold20(),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Appcolors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppSizes.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile section
                ProfileSection(
                  selectedProfileImage: selectedProfileImage,
                  onProfileImageSelected: (index) {
                    setState(() {
                      selectedProfileImage = index;
                    });
                  },
                ),

                AppSizes.gapH32,

                // Preferences section
                PreferencesSection(
                  notificationsEnabled: notificationsEnabled,
                  onNotificationToggle: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                  },
                  selectedTheme: selectedTheme,
                  onThemeChanged: (theme) {
                    setState(() {
                      selectedTheme = theme;
                      if (theme == ThemeMode.dark) {
                        isDarkModeEnabled = true;
                      } else if (theme == ThemeMode.light) {
                        isDarkModeEnabled = false;
                      }
                    });
                  },
                  isDarkModeEnabled: isDarkModeEnabled,
                  onDarkModeToggle: (value) {
                    setState(() {
                      isDarkModeEnabled = value;
                      if (value) {
                        selectedTheme = ThemeMode.dark;
                      } else {
                        selectedTheme = ThemeMode.light;
                      }
                    });
                  },
                ),

                AppSizes.gapH32,

                // Account section
                const AccountSection(),

                AppSizes.gapH32,

                // Buttons section
                ButtonsSection(
                  onSaveChanges: () {
                    // Save profile changes
                    setState(() {
                      profileimagesindex = selectedProfileImage;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Appcolors.purple,
                        content: Text('Profile updated successfully!',
                            style: AppTypography.medium14()
                                .copyWith(color: Appcolors.white)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                    context.pop();
                  },
                ),

                AppSizes.gapH16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
