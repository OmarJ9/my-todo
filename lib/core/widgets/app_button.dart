import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.color,
    required this.width,
    required this.title,
    required this.onClick,
  });

  final Color color;
  final double width;
  final String title;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        minimumSize: Size(width, 30.h),
      ),
      child: Text(
        title,
        style: AppTypography.medium16().copyWith(color: Colors.white),
      ),
    );
  }
}
