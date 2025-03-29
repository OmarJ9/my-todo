import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_thems.dart';

class ColorPickerSection extends StatefulWidget {
  final int selectedColorIndex;
  final Function(int) onColorSelected;

  const ColorPickerSection({
    super.key,
    required this.selectedColorIndex,
    required this.onColorSelected,
  });

  @override
  State<ColorPickerSection> createState() => _ColorPickerSectionState();
}

class _ColorPickerSectionState extends State<ColorPickerSection> {
  int _selectedColorIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedColorIndex = widget.selectedColorIndex;
  }

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
            itemCount: AppTheme.themes.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedColorIndex = index);
                    widget.onColorSelected(index);
                  },
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppTheme
                        .themes[AppThemeColor.values[index]]?.primaryColor,
                    child: _selectedColorIndex == index
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
