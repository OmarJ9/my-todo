import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/features/task/cubit/task_cubit.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/profile/presentation/profile_header.dart';
import 'package:todo_app/features/task/presentation/screens/home/widgets/date_picker_section.dart';
import 'package:todo_app/features/task/presentation/screens/home/widgets/task_list_section.dart';

import '../../../../../core/route/app_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static var currentdate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    context.read<TaskCubit>().getTasks(
          DateFormat('yyyy-MM-dd').format(currentdate),
        );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileSection(),
              AppSizes.gapH4,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    DateFormat('MMMM, dd').format(currentdate),
                    style: AppTypography.medium18(),
                  ),
                  const Spacer(),
                  AppButton(
                    color: context.theme.primaryColor,
                    width: 150.w,
                    title: '+ Add Task',
                    onClick: () {
                      context.pushNamed(RouteNames.addtaskpage, extra: {
                        'date': currentdate,
                      });
                    },
                  )
                ],
              ),
              AppSizes.gapH24,
              DatePickerSection(
                currentDate: currentdate,
                onDateSelected: (DateTime newdate) {
                  setState(() {
                    currentdate = newdate;
                  });
                  _loadTasks();
                },
              ),
              AppSizes.gapH24,
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: context.theme.primaryColor,
                  ),
                  AppSizes.gapW8,
                  Text(
                    "All The Tasks For  ",
                    style: AppTypography.medium14(),
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(currentdate),
                    style: AppTypography.medium14(
                        color: context.theme.primaryColor),
                  ),
                ],
              ),
              AppSizes.gapH12,
              Expanded(
                child: TaskListSection(selectedDate: currentdate),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
