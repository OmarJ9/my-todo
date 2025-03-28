import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/theme/app_thems.dart';
import 'package:todo_app/core/theme/theme_cubit.dart';
import 'package:todo_app/core/widgets/app_alerts.dart';
import 'package:todo_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:todo_app/features/profile/presentation/widgets/account_section.dart';
import 'package:todo_app/features/profile/presentation/widgets/buttons_section.dart';
import 'package:todo_app/features/profile/presentation/widgets/preferences_section.dart';
import 'package:todo_app/features/profile/presentation/widgets/profile_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _userController = TextEditingController();
  int selectedProfileImage = 0;
  bool notificationsEnabled = false;
  ThemeMode selectedTheme = ThemeMode.system;
  bool isDarkModeEnabled = false;
  String email = '';
  AppThemeColor selectedThemeColor = AppThemeColor.purple;

  @override
  void initState() {
    super.initState();
    // Get user profile on init
    context.read<ProfileCubit>().getProfile();

    // Initialize the selected theme color based on current theme
    final currentTheme = context.read<ThemeCubit>().state;
    for (var entry in AppTheme.themes.entries) {
      if (entry.value == currentTheme) {
        selectedThemeColor = entry.key;
        break;
      }
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded) {
          setState(() {
            // Update UI with user data
            _userController.text = state.user.username ?? 'User';
            if (state.user.avatarIndex != null) {
              selectedProfileImage = state.user.avatarIndex!;
            }
            email = state.user.email ?? 'User@gmail.com';
          });
        } else if (state is ProfileUpdated) {
          Alerts.of(context).showSuccess('Profile updated successfully');
          context.pop();
        } else if (state is ProfileError) {
          Alerts.of(context).showError(state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Settings',
            style: AppTypography.bold20(),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
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
                        usernameController: _userController,
                        email: email,
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
                        selectedThemeColor: selectedThemeColor,
                        onThemeColorChanged: (themeColor) {
                          setState(() {
                            selectedThemeColor = themeColor;
                          });
                          // Update the app theme using the ThemeCubit
                          context.read<ThemeCubit>().changeTheme(themeColor);
                        },
                      ),

                      AppSizes.gapH32,

                      // Account section
                      const AccountSection(),

                      AppSizes.gapH32,

                      // Buttons section
                      ButtonsSection(
                        onSaveChanges: () {
                          // Save profile changes using cubit
                          context.read<ProfileCubit>().updateProfile(
                                username: _userController.text,
                                avatarIndex: selectedProfileImage,
                              );
                        },
                      ),

                      AppSizes.gapH16,
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
