import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

class OnBoardItem extends StatelessWidget {
  const OnBoardItem({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 5.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppSizes.gapH48,
          SizedBox(
            height: 200.h,
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
          AppSizes.gapH48,
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTypography.bold24(),
          ),
          AppSizes.gapH24,
          Text(
            description,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: AppTypography.medium16(),
          ),
        ],
      ),
    );
  }
}
