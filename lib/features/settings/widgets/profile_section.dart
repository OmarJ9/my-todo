import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_variables.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/core/theme/app_styles.dart';

class ProfileSection extends StatelessWidget {
  final int selectedProfileImage;
  final Function(int) onProfileImageSelected;

  const ProfileSection({
    super.key,
    required this.selectedProfileImage,
    required this.onProfileImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile section
        Center(
          child: Column(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    profileimages[selectedProfileImage],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AppSizes.gapH16,
              Text(
                'Change Profile Picture',
                style:
                    AppTypography.medium16().copyWith(color: Appcolors.purple),
              ),
            ],
          ),
        ),
        AppSizes.gapH32,

        // Profile pictures selection
        Text(
          'Select Profile Picture',
          style: AppTypography.bold16(),
        ),
        AppSizes.gapH16,
        SizedBox(
          height: 80.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: profileimages.length,
            separatorBuilder: (context, index) => AppSizes.gapW16,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onProfileImageSelected(index),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: selectedProfileImage == index
                        ? Border.all(color: Appcolors.purple, width: 2)
                        : null,
                  ),
                  child: CircleAvatar(
                    radius: 30.r,
                    backgroundImage: AssetImage(profileimages[index]),
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
