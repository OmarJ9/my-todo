import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/utils/extensions.dart';

class ProfileNotificationCheckbox extends StatefulWidget {
  const ProfileNotificationCheckbox({super.key});

  @override
  State<ProfileNotificationCheckbox> createState() =>
      _ProfileNotificationCheckboxState();
}

class _ProfileNotificationCheckboxState
    extends State<ProfileNotificationCheckbox> {
  bool _notificationsEnabled = true;

  void _toggleNotifications() {
    setState(() {
      _notificationsEnabled = !_notificationsEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.notifications_outlined,
                color: context.theme.primaryColor),
          ),
          AppSizes.gapW16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: AppTypography.medium16(),
                ),
                Text(
                  'Enable or disable notifications',
                  style: AppTypography.medium12().copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(
            value: _notificationsEnabled,
            onChanged: (value) {
              _toggleNotifications();
            },
            activeColor: context.theme.primaryColor,
          ),
        ],
      ),
    );
  }
}
