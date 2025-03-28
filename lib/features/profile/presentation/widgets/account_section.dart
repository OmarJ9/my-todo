import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/utils/extensions.dart';

class AccountSection extends StatelessWidget {
  const AccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account',
          style: AppTypography.bold16(),
        ),
        AppSizes.gapH16,
        _buildPreferenceItem(
          icon: Icons.lock_outline,
          title: 'Privacy',
          subtitle: 'Manage your privacy settings',
          onTap: () {
            // Navigate to privacy settings
          },
          color: context.theme.primaryColor,
        ),
        _buildPreferenceItem(
          icon: Icons.help_outline,
          title: 'Help & Support',
          subtitle: 'Get help or contact support',
          onTap: () {
            // Navigate to help and support
          },
          color: context.theme.primaryColor,
        ),
        _buildPreferenceItem(
          icon: Icons.info_outline,
          title: 'About',
          subtitle: 'App information and version',
          onTap: () {
            // Navigate to about page
          },
          color: context.theme.primaryColor,
        ),
      ],
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required Color color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color),
            ),
            AppSizes.gapW16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.medium16(),
                  ),
                  Text(
                    subtitle,
                    style:
                        AppTypography.medium12().copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
