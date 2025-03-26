import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/theme/app_styles.dart';

class DatePickerSection extends StatelessWidget {
  final DateTime currentDate;
  final Function(DateTime) onDateSelected;

  const DatePickerSection({
    super.key,
    required this.currentDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      DateTime.now(),
      height: 100.h,
      width: 80.w,
      initialSelectedDate: currentDate,
      selectionColor: Colors.deepPurple,
      selectedTextColor: Colors.white,
      dateTextStyle: AppTypography.medium14(),
      dayTextStyle: AppTypography.medium14(),
      monthTextStyle: AppTypography.medium14(),
      onDateChange: onDateSelected,
    );
  }
}
