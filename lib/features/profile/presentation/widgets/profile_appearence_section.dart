import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_styles.dart';

import 'profile_theme_selector.dart';

class AppearanceSection extends StatelessWidget {
  const AppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appearance',
          style: AppTypography.bold16(),
        ),
        AppSizes.gapH16,
        const ProfileThemeSelector(),
      ],
    );
  }
}
