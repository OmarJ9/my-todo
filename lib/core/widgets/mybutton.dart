import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/core/theme/app_colors.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.color,
      required this.width,
      required this.title,
      required this.func});

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
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(fontSize: 13, color: Appcolors.white),
        ),
      ),
    );
  }
}
