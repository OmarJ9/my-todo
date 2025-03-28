import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/core/theme/app_styles.dart';

class PreferencesSection extends StatefulWidget {
  final bool notificationsEnabled;
  final Function(bool) onNotificationToggle;
  final ThemeMode selectedTheme;
  final Function(ThemeMode) onThemeChanged;
  final bool isDarkModeEnabled;
  final Function(bool) onDarkModeToggle;

  const PreferencesSection({
    super.key,
    required this.notificationsEnabled,
    required this.onNotificationToggle,
    required this.selectedTheme,
    required this.onThemeChanged,
    required this.isDarkModeEnabled,
    required this.onDarkModeToggle,
  });

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

        // Notifications setting with checkbox
        _buildNotificationToggle(),

        // Theme selection
        _buildThemeSelector(),
      ],
    );
  }

  Widget _buildNotificationToggle() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.notifications_outlined, color: Appcolors.purple),
          ),
          AppSizes.gapW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: AppTypography.medium16(),
                ),
                Text(
                  'Enable or disable notifications',
                  style: AppTypography.medium12().copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: widget.notificationsEnabled,
            onChanged: widget.onNotificationToggle,
            activeColor: Appcolors.purple,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.notifications_outlined, color: Appcolors.purple),
          ),
          AppSizes.gapW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appearance',
                  style: AppTypography.medium16(),
                ),
                Text(
                  'Enable or disable dark mode',
                  style: AppTypography.medium12().copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: widget.isDarkModeEnabled,
            onChanged: widget.onDarkModeToggle,
            activeColor: Appcolors.black,
          ),
        ],
      ),
    );
  }
}
