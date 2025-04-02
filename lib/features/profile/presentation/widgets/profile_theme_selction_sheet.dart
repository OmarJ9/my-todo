import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/theme/app_styles.dart';
import '../../../../core/theme/app_thems.dart';
import 'profile_selection_sheet.dart';

class ThemeSelectionSheet extends StatelessWidget {
  final AppThemeColor selectedThemeColor;
  final Function(AppThemeColor) onThemeColorSelected;

  const ThemeSelectionSheet({
    super.key,
    required this.selectedThemeColor,
    required this.onThemeColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetHandleBar(),
          AppSizes.gapH24,
          SheetHeader(title: 'Choose Theme Color'),
          AppSizes.gapH24,
          ThemeColorsGrid(
            selectedThemeColor: selectedThemeColor,
            onThemeColorSelected: onThemeColorSelected,
          ),
          AppSizes.gapH32,
          ThemeLabelsGrid(selectedThemeColor: selectedThemeColor),
          AppSizes.gapH32,
        ],
      ),
    );
  }
}

class ThemeColorsGrid extends StatelessWidget {
  final AppThemeColor selectedThemeColor;
  final Function(AppThemeColor) onThemeColorSelected;

  const ThemeColorsGrid({
    super.key,
    required this.selectedThemeColor,
    required this.onThemeColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20.h,
        crossAxisSpacing: 20.w,
        childAspectRatio: 1,
      ),
      itemCount: AppThemeColor.values.length,
      itemBuilder: (context, index) {
        final themeColor = AppThemeColor.values[index];
        final isSelected = selectedThemeColor == themeColor;

        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
          child: GestureDetector(
            onTap: () => onThemeColorSelected(themeColor),
            child: ThemeColorItem(
              themeColor: themeColor,
              isSelected: isSelected,
            ),
          ),
        );
      },
    );
  }
}

class ThemeColorItem extends StatelessWidget {
  final AppThemeColor themeColor;
  final bool isSelected;

  const ThemeColorItem({
    super.key,
    required this.themeColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.themes[themeColor]!.primaryColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.black : Colors.transparent,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isSelected
          ? const Icon(
              Icons.check,
              color: Colors.white,
              size: 30,
            )
          : null,
    );
  }
}

class ThemeLabelsGrid extends StatelessWidget {
  final AppThemeColor selectedThemeColor;

  const ThemeLabelsGrid({
    super.key,
    required this.selectedThemeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ThemeLabel(
              label: 'Purple',
              isSelected: AppThemeColor.purple == selectedThemeColor,
            ),
            ThemeLabel(
              label: 'Green',
              isSelected: AppThemeColor.green == selectedThemeColor,
            ),
            ThemeLabel(
              label: 'Orange',
              isSelected: AppThemeColor.orange == selectedThemeColor,
            ),
          ],
        ),
        AppSizes.gapH16,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ThemeLabel(
              label: 'Red',
              isSelected: AppThemeColor.red == selectedThemeColor,
            ),
            ThemeLabel(
              label: 'Teal',
              isSelected: AppThemeColor.teal == selectedThemeColor,
            ),
            ThemeLabel(
              label: 'Pink',
              isSelected: AppThemeColor.pink == selectedThemeColor,
            ),
          ],
        ),
      ],
    );
  }
}

class ThemeLabel extends StatelessWidget {
  final String label;
  final bool isSelected;

  const ThemeLabel({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      from: 10,
      duration: const Duration(milliseconds: 400),
      child: Text(
        label,
        style: AppTypography.medium14().copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
