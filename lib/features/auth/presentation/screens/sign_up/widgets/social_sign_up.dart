import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/theme/app_colors.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Image.asset(
                AppAssets.googleicon,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 40.w),
            InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'It will be added soon!!',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: 11.sp,
                            color: Appcolors.white,
                          ),
                    ),
                    backgroundColor: Colors.deepPurple,
                  ),
                );
              },
              child: Image.asset(
                AppAssets.facebookicon,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
