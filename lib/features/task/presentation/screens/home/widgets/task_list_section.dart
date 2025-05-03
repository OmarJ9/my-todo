import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/theme/app_thems.dart';
import 'package:todo_app/core/widgets/app_alerts.dart';
import 'package:todo_app/features/task/blocs/task/task_cubit.dart';
import 'package:todo_app/features/task/presentation/screens/home/widgets/task_card.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../core/route/app_router.dart';

class TaskListSection extends StatelessWidget {
  final DateTime selectedDate;

  const TaskListSection({
    super.key,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskError) {
          Alerts.of(context).showError(state.message);
        }
      },
      builder: (context, state) {
        if (state is TaskLoading) {
          return const AppCircularIndicator();
        }

        if (state is TaskLoaded) {
          final tasks = state.tasks;

          return tasks.isNotEmpty
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    var task = tasks[index];
                    Widget taskcontainer = TaskCard(
                      id: task.id ?? '',
                      color: AppTheme
                          .themes[AppThemeColor.values[task.colorIndex ?? 0]]!
                          .primaryColor,
                      title: task.title ?? '',
                      time: task.time ?? '',
                      note: task.note ?? '',
                    );
                    return InkWell(
                      onTap: () => context.pushNamed(
                        RouteNames.addtaskpage,
                        extra: {
                          'task': task,
                          'date': selectedDate,
                        },
                      ),
                      child: index % 2 == 0
                          ? BounceInLeft(
                              duration: const Duration(milliseconds: 1000),
                              child: taskcontainer)
                          : BounceInRight(
                              duration: const Duration(milliseconds: 1000),
                              child: taskcontainer),
                    );
                  },
                )
              : _buildNoDataWidget();
        }

        return _buildNoDataWidget();
      },
    );
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.clipboard,
            width: 100.w,
            height: 100.h,
          ),
          AppSizes.gapH24,
          Text(
            'No Tasks for this date',
            style: AppTypography.medium14(),
          ),
        ],
      ),
    );
  }
}
