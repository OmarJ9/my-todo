import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_sizes.dart';
import '../theme/app_styles.dart';
import '../theme/app_colors.dart';

class Alerts {
  final BuildContext context;

  Alerts.of(this.context);

  void showError(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.dangerous_rounded,
                color: Appcolors.red,
                size: 48.sp,
              ),
              AppSizes.gapW8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Erreur est survenue',
                      style: AppTypography.bold16(
                        color: Appcolors.red,
                      ),
                    ),
                    Text(
                      message,
                      style: AppTypography.medium12(
                        color: Appcolors.red,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(
              color: Appcolors.red,
              width: 2.w,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 15.h,
          ),
          backgroundColor: Colors.red.shade50,
          margin: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            bottom: MediaQuery.of(context).size.height - 180.h,
          ),
        ),
      );
  }

  void showSuccess(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: Appcolors.red,
                size: 48.sp,
              ),
              AppSizes.gapW8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Congratulation',
                      style: AppTypography.bold16(
                        color: Appcolors.red,
                      ),
                    ),
                    Text(
                      message,
                      style: AppTypography.medium12(
                        color: Appcolors.red,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(
              color: Appcolors.red,
              width: 2.w,
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 15.h,
          ),
          backgroundColor: Colors.green.shade50,
          margin: EdgeInsets.only(
            left: 12.w,
            right: 12.w,
            bottom: MediaQuery.of(context).size.height - 180.h,
          ),
        ),
      );
  }
}
