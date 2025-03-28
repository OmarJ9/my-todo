import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.color,
    required this.width,
    required this.title,
    required this.func,
  });

  final Color color;
  final double width;
  final String title;
  final Function() func;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 0.1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        color: color,
      ),
      child: MaterialButton(
        onPressed: func,
        child: Text(
          title,
          style: AppTypography.medium16().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
