import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/extensions.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_styles.dart';
import '../../cubit/profile_cubit.dart';

class AppearanceSection extends StatelessWidget {
  final ProfileLoaded state;
  final VoidCallback onTap;

  const AppearanceSection({
    super.key,
    required this.state,
    required this.onTap,
  });

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
        ThemeCard(
          state: state,
          onTap: onTap,
        ),
      ],
    );
  }
}

class ThemeCard extends StatelessWidget {
  final ProfileLoaded state;
  final VoidCallback onTap;

  const ThemeCard({
    super.key,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Icon(Icons.palette, color: context.theme.primaryColor),
            ),
            AppSizes.gapW16,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: AppTypography.medium16(),
                  ),
                  AppSizes.gapH8,
                  Text(
                    'Change the theme of the app',
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
