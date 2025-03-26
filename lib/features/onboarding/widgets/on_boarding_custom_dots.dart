import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_colors.dart';

class CustomDots extends StatelessWidget {
  final int myindex;
  const CustomDots({super.key, required this.myindex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 40.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDot(0),
          _buildDot(1),
          _buildDot(2),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == myindex ? Appcolors.white : Colors.white54),
    );
  }
}
