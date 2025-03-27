import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_variables.dart';
import 'package:todo_app/core/route/app_router.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    String username = 'User';

    return Row(
      children: [
        SizedBox(
          height: 50.h,
          child: Image.asset(
            profileimages[profileimagesindex],
            fit: BoxFit.cover,
          ),
        ),
        AppSizes.gapW4,
        Expanded(
          child: Text(
            'Hello $username',
            overflow: TextOverflow.ellipsis,
            style: AppTypography.medium18(),
          ),
        ),
        InkWell(
          onTap: () => context.pushNamed(RouteNames.settingspage),
          child: Icon(
            Icons.settings,
            size: 30.sp,
            color: Appcolors.black,
          ),
        )
      ],
    );
  }
}
