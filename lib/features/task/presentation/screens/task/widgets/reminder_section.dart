import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

class ReminderSection extends StatelessWidget {
  final int selectedReminder;
  final Function(int) onReminderSelected;

  const ReminderSection({
    super.key,
    required this.selectedReminder,
    required this.onReminderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reminder',
          style: AppTypography.medium14(),
        ),
        AppSizes.gapH12,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<int>(
            value: selectedReminder,
            isExpanded: true,
            underline: const SizedBox(),
            items: const [
              DropdownMenuItem(
                value: 5,
                child: Text("5 Min Earlier"),
              ),
              DropdownMenuItem(
                value: 10,
                child: Text("10 Min Earlier"),
              ),
              DropdownMenuItem(
                value: 15,
                child: Text("15 Min Earlier"),
              ),
              DropdownMenuItem(
                value: 20,
                child: Text("20 Min Earlier"),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onReminderSelected(value);
              }
            },
          ),
        ),
      ],
    );
  }
}
