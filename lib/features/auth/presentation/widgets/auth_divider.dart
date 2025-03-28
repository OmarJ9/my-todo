import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 1.h,
          color: Colors.black,
        ),
        AppSizes.gapW12,
        Text(
          'Or',
          style: AppTypography.medium14(color: Colors.deepPurple),
        ),
        AppSizes.gapW12,
        Container(
          width: 80.w,
          height: 1.h,
          color: Colors.black,
        ),
      ],
    );
  }
}
