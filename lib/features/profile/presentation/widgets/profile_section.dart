import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animate_do/animate_do.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/constants/app_variables.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/utils/extensions.dart';

class ProfileSection extends StatelessWidget {
  final int selectedProfileImage;
  final Function(int) onProfileImageSelected;
  final String email;

  const ProfileSection({
    super.key,
    required this.selectedProfileImage,
    required this.onProfileImageSelected,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile avatar section
          Center(
            child: Column(
              children: [
                // Profile avatar with animations
                FadeIn(
                  duration: const Duration(milliseconds: 800),
                  child: Material(
                    elevation: 8,
                    shadowColor: context.theme.primaryColor.withOpacity(0.2),
                    shape: const CircleBorder(),
                    child: Container(
                      height: 120.h,
                      width: 120.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: context.theme.primaryColor.withOpacity(0.7),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: context.theme.primaryColor.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 2,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image.asset(
                          profileimages[selectedProfileImage],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                AppSizes.gapH16,

                // Email text with animation
                FadeInUp(
                  from: 20,
                  duration: const Duration(milliseconds: 500),
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    email,
                    style: AppTypography.medium16().copyWith(
                      color: context.theme.primaryColor,
                      fontSize: 18.sp,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h),

          // Profile selection section styled like AppearanceSection
          FadeInUp(
            from: 30,
            delay: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile',
                  style: AppTypography.bold16(),
                ),
                AppSizes.gapH16,

                // Profile selection card
                Column(
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
                          child: Icon(
                            Icons.person_outline,
                            color: context.theme.primaryColor,
                          ),
                        ),
                        AppSizes.gapW16,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Profile Picture',
                                style: AppTypography.medium16(),
                              ),
                              Text(
                                'Choose your profile picture',
                                style: AppTypography.medium12().copyWith(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    AppSizes.gapH16,

                    // Profile images grid
                    Center(
                      child: SizedBox(
                        height: 90.h,
                        width: .7.sw,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            profileimages.length,
                            (index) {
                              final isSelected = selectedProfileImage == index;
                              return GestureDetector(
                                onTap: () => onProfileImageSelected(index),
                                child: ZoomIn(
                                  delay: Duration(milliseconds: 100 * index),
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? context.theme.primaryColor
                                            : Colors.transparent,
                                        width: 3,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color: context
                                                    .theme.primaryColor
                                                    .withOpacity(0.3),
                                                blurRadius: 8,
                                                spreadRadius: 2,
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: CircleAvatar(
                                      radius: 32.r,
                                      backgroundImage:
                                          AssetImage(profileimages[index]),
                                      child: isSelected
                                          ? Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: context
                                                    .theme.primaryColor
                                                    .withOpacity(0.2),
                                              ),
                                              child: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 24.sp,
                                              ),
                                            )
                                          : null,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
