import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_colors.dart';

class AppCircularButton extends StatelessWidget {
  const AppCircularButton({
    super.key,
    required this.color,
    required this.width,
    required this.icon,
    required this.func,
    required this.condition,
    required this.text,
  });

  final Color color;
  final double width;
  final IconData icon;
  final Function() func;
  final String text;
  final bool condition;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: MaterialButton(
          onPressed: func,
          child: Center(
            child: (condition)
                ? Icon(
                    icon,
                    color: Appcolors.white,
                    size: 30.sp,
                  )
                : Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .displayLarge
                        ?.copyWith(fontSize: 9.sp, color: Appcolors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
