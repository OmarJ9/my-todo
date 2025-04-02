import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/extensions.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../core/constants/app_variables.dart';
import '../../../../core/theme/app_styles.dart';

class ProfileSelectionSheet extends StatelessWidget {
  final int selectedProfileImage;
  final Function(int) onProfileSelected;

  const ProfileSelectionSheet({
    super.key,
    required this.selectedProfileImage,
    required this.onProfileSelected,
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
          SheetHeader(title: 'Choose Profile Picture'),
          AppSizes.gapH24,
          ProfileImagesGrid(
            selectedProfileImage: selectedProfileImage,
            onProfileSelected: onProfileSelected,
          ),
          AppSizes.gapH24,
        ],
      ),
    );
  }
}

class SheetHandleBar extends StatelessWidget {
  const SheetHandleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 5.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}

class SheetHeader extends StatelessWidget {
  final String title;

  const SheetHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTypography.bold20(),
        ),
        const Spacer(),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              size: 20.sp,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileImagesGrid extends StatelessWidget {
  final int selectedProfileImage;
  final Function(int) onProfileSelected;

  const ProfileImagesGrid({
    super.key,
    required this.selectedProfileImage,
    required this.onProfileSelected,
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
      itemCount: profileimages.length,
      itemBuilder: (context, index) {
        final isSelected = selectedProfileImage == index;
        return FadeInUp(
          delay: Duration(milliseconds: 100 * index),
          duration: const Duration(milliseconds: 400),
          child: GestureDetector(
            onTap: () => onProfileSelected(index),
            child: ProfileImageItem(
              imageIndex: index,
              isSelected: isSelected,
            ),
          ),
        );
      },
    );
  }
}

class ProfileImageItem extends StatelessWidget {
  final int imageIndex;
  final bool isSelected;

  const ProfileImageItem({
    super.key,
    required this.imageIndex,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? context.theme.primaryColor : Colors.transparent,
          width: 3,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: context.theme.primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: CircleAvatar(
        radius: 45.r,
        backgroundImage: AssetImage(profileimages[imageIndex]),
        child: isSelected
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.primaryColor.withOpacity(0.2),
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 24.sp,
                ),
              )
            : null,
      ),
    );
  }
}
