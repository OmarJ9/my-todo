import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/extensions.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_variables.dart';
import '../../../../core/theme/app_styles.dart';
import '../../cubit/profile_cubit.dart';

class ProfileSection extends StatelessWidget {
  final ProfileLoaded state;
  final VoidCallback onTap;

  const ProfileSection({
    super.key,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                ProfileAvatar(
                  selectedProfileImage: state.selectedProfileImage,
                  onTap: onTap,
                ),
                AppSizes.gapH16,
                ProfileEmail(email: state.user.email ?? ''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final int selectedProfileImage;
  final VoidCallback onTap;

  const ProfileAvatar({
    super.key,
    required this.selectedProfileImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FadeIn(
        duration: const Duration(milliseconds: 800),
        child: Stack(
          children: [
            Material(
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
            EditButton(),
          ],
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  const EditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: context.theme.primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 18.sp,
        ),
      ),
    );
  }
}

class ProfileEmail extends StatelessWidget {
  final String email;

  const ProfileEmail({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
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
    );
  }
}
