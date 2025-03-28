import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/utils/extensions.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.color,
    required this.width,
    required this.title,
    this.onClick,
    this.isOutlined = false,
    this.height = 35,
  });

  final Color color;
  final double width;
  final double height;
  final String title;
  final Function()? onClick;
  final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOutlined ? Colors.white : color,
        elevation: isOutlined ? 0 : 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: isOutlined
              ? BorderSide(color: color, width: 1.5)
              : BorderSide.none,
        ),
        padding: EdgeInsets.symmetric(vertical: 10.h),
        minimumSize: Size(width, height),
        shadowColor: isOutlined
            ? Colors.transparent
            : Colors.deepPurple.withOpacity(0.4),
      ),
      child: Text(
        title,
        style: AppTypography.medium16().copyWith(
          color: isOutlined ? context.theme.primaryColor : Colors.white,
        ),
      ),
    );
  }
}
