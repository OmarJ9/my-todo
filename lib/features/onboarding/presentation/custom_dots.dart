import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/core/theme/colors.dart';

class CustomDots extends StatelessWidget {
  final int myindex;
  const CustomDots({super.key, required this.myindex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16.w,
      height: 10.h,
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
