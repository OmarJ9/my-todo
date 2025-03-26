import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_variables.dart';

class ColorPickerSection extends StatelessWidget {
  final int selectedColorIndex;
  final Function(int) onColorSelected;

  const ColorPickerSection({
    super.key,
    required this.selectedColorIndex,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: AppTypography.medium14(),
        ),
        AppSizes.gapH12,
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: () => onColorSelected(index),
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: colors[index],
                    child: selectedColorIndex == index
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
