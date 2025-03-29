import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/widgets/app_alerts.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:todo_app/features/task/blocs/task/task_cubit.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/task_form_section.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? task;
  final DateTime date;

  const AddTaskScreen({
    this.task,
    required this.date,
    super.key,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            Alerts.of(context).showError(state.message);
          } else if (state is TaskAdded || state is TaskUpdated) {
            context.read<TaskCubit>().getTasks(
                  DateFormat('yyyy-MM-dd').format(widget.date),
                );
            context.pop();
          }
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSizes.gapH12,
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back),
                      ),
                      AppSizes.gapW12,
                      Text(
                        widget.task != null ? 'Edit Task' : 'Add Task',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  AppSizes.gapH32,
                  TaskFormSection(
                    initialTask: widget.task,
                    initialDate: widget.date,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
