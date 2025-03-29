import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_styles.dart';

import 'profile_notification_checkbox.dart';
import 'profile_theme_selector.dart';

class PreferencesSection extends StatefulWidget {
  const PreferencesSection({super.key});

  @override
  State<PreferencesSection> createState() => _PreferencesSectionState();
}

class _PreferencesSectionState extends State<PreferencesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferences',
          style: AppTypography.bold16(),
        ),
        AppSizes.gapH16,
        const ProfileNotificationCheckbox(),
        const ProfileThemeSelector(),
      ],
    );
  }
}
