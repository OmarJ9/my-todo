import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/theme/app_thems.dart';
import 'package:todo_app/core/utils/extensions.dart';

class PreferencesSection extends StatefulWidget {
  final bool notificationsEnabled;
  final Function(bool) onNotificationToggle;
  final ThemeMode selectedTheme;
  final Function(ThemeMode) onThemeChanged;
  final bool isDarkModeEnabled;
  final Function(bool) onDarkModeToggle;
  final AppThemeColor selectedThemeColor;
  final Function(AppThemeColor) onThemeColorChanged;

  const PreferencesSection({
    super.key,
    required this.notificationsEnabled,
    required this.onNotificationToggle,
    required this.selectedTheme,
    required this.onThemeChanged,
    required this.isDarkModeEnabled,
    required this.onDarkModeToggle,
    required this.selectedThemeColor,
    required this.onThemeColorChanged,
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

        // Theme color selection
        _buildThemeColorSelector(),
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
            child: Icon(Icons.notifications_outlined,
                color: context.theme.primaryColor),
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
            activeColor: context.theme.primaryColor,
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
            child: Icon(Icons.dark_mode_outlined,
                color: context.theme.primaryColor),
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
            activeColor: context.theme.primaryColor,
          ),
        ],
      ),
    );
  }

  Widget _buildThemeColorSelector() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.color_lens_outlined,
                    color: context.theme.primaryColor),
              ),
              AppSizes.gapW16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme Color',
                      style: AppTypography.medium16(),
                    ),
                    Text(
                      'Choose app accent color',
                      style:
                          AppTypography.medium12().copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSizes.gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildColorOption(AppThemeColor.purple, Colors.deepPurple),
              _buildColorOption(AppThemeColor.green, Colors.green),
              _buildColorOption(AppThemeColor.orange, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(AppThemeColor themeColor, Color color) {
    final isSelected = widget.selectedThemeColor == themeColor;

    return GestureDetector(
      onTap: () => widget.onThemeColorChanged(themeColor),
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border:
              isSelected ? Border.all(color: Colors.black, width: 2.w) : null,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isSelected ? Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
