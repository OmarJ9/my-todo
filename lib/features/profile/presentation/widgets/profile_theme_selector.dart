import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/theme/app_thems.dart';
import 'package:todo_app/core/utils/extensions.dart';

import '../../../../core/theme/theme_cubit.dart';
import '../../cubit/profile_cubit.dart';

class ProfileThemeSelector extends StatefulWidget {
  const ProfileThemeSelector({super.key});

  @override
  State<ProfileThemeSelector> createState() => _ProfileThemeSelectorState();
}

class _ProfileThemeSelectorState extends State<ProfileThemeSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.color_lens_outlined,
                    color: context.theme.primaryColor),
              ),
              AppSizes.gapW16,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Theme Color',
                      style: AppTypography.medium16(),
                    ),
                    Text(
                      'Choose app accent color',
                      style:
                          AppTypography.medium12().copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppSizes.gapH16,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildColorOption(AppThemeColor.purple, Colors.deepPurple),
              _buildColorOption(AppThemeColor.green, Colors.green),
              _buildColorOption(AppThemeColor.orange, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(AppThemeColor themeColor, Color color) {
    final profileCubit = context.read<ProfileCubit>();
    final isSelected = profileCubit.selectedThemeColor == themeColor;

    return GestureDetector(
      onTap: () =>
          profileCubit.changeThemeColor(themeColor, context.read<ThemeCubit>()),
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border:
              isSelected ? Border.all(color: Colors.black, width: 2.w) : null,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: isSelected ? Icon(Icons.check, color: Colors.white) : null,
      ),
    );
  }
}
