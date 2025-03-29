import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/core/widgets/app_alerts.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/task_form_section.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/color_picker_section.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/reminder_section.dart';
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
  get isEditMode => widget.task != null;

  late String _title;
  late String _note;
  late DateTime _date;
  late int _reminder;
  late int _colorIndex;

  @override
  void initState() {
    super.initState();
    _initializeValues();
  }

  void _initializeValues() {
    if (isEditMode) {
      final task = widget.task!;
      _title = task.title ?? '';
      _note = task.note ?? '';
      _date = task.date != null
          ? DateFormat('yyyy-MM-dd').parse(task.date!)
          : DateTime.now();

      _reminder = task.reminder ?? 5;
      _colorIndex = task.colorindex ?? 0;
    } else {
      _title = '';
      _note = '';
      _date = DateTime.now();

      _reminder = 5;
      _colorIndex = 0;
    }
  }

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
                  _buildAppBar(context),
                  AppSizes.gapH32,
                  TaskFormSection(
                    initialTitle: _title,
                    initialNote: _note,
                    initialDate: _date,
                    initialReminder: _reminder,
                    initialColorIndex: _colorIndex,
                    onTitleChanged: (value) => setState(() => _title = value),
                    onNoteChanged: (value) => setState(() => _note = value),
                    onDateChanged: (value) => setState(() => _date = value),
                    onReminderChanged: (value) =>
                        setState(() => _reminder = value),
                    onColorChanged: (value) =>
                        setState(() => _colorIndex = value),
                  ),
                  AppSizes.gapH24,
                  ReminderSection(
                    selectedReminder: _reminder,
                    onReminderSelected: (value) =>
                        setState(() => _reminder = value),
                  ),
                  AppSizes.gapH24,
                  ColorPickerSection(
                    selectedColorIndex: _colorIndex,
                    onColorSelected: (value) =>
                        setState(() => _colorIndex = value),
                  ),
                  AppSizes.gapH32,
                  AppButton(
                    color: context.theme.primaryColor,
                    width: 1.sw,
                    title: isEditMode ? 'Update Task' : 'Add Task',
                    onClick: () => _handleSubmit(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        AppSizes.gapW12,
        Text(
          isEditMode ? 'Edit Task' : 'Add Task',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }

  void _handleSubmit(BuildContext context) {
    if (_title.isEmpty || _note.isEmpty) {
      Alerts.of(context).showError('Please fill in all fields');
      return;
    }

    final task = TaskModel(
      id: widget.task?.id,
      title: _title,
      note: _note,
      date: DateFormat('yyyy-MM-dd').format(_date),
      time: DateFormat('hh:mm a').format(_date),
      reminder: _reminder,
      colorindex: _colorIndex,
    );

    if (isEditMode) {
      context.read<TaskCubit>().updateTask(task);
    } else {
      context.read<TaskCubit>().addTask(task);
    }
  }
}
