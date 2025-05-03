import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/widgets/app_textfield.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/color_picker_section.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/reminder_section.dart';

import '../../../../../../core/services/local_notifications_service.dart';
import '../../../../../../core/widgets/app_alerts.dart';
import '../../../../blocs/task/task_cubit.dart';

class TaskFormSection extends StatefulWidget {
  final TaskModel? initialTask;
  final DateTime initialDate;

  const TaskFormSection({
    super.key,
    this.initialTask,
    required this.initialDate,
  });

  @override
  State<TaskFormSection> createState() => _TaskFormSectionState();
}

class _TaskFormSectionState extends State<TaskFormSection> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;
  late DateTime _date;
  late int _reminder;
  late int _colorIndex;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTask?.title);
    _noteController = TextEditingController(text: widget.initialTask?.note);
    _date = widget.initialDate;
    _reminder = widget.initialTask?.reminder ?? 5;
    _colorIndex = widget.initialTask?.colorIndex ?? 0;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          AppSizes.gapH12,
          Text(
            'Title',
            style: AppTypography.medium14(),
          ),
          AppSizes.gapH12,
          AppTextfield(
            hint: 'Enter Title',
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Title" : null;
            },
            textEditingController: _titleController,
          ),

          // Note Section
          AppSizes.gapH24,
          Text(
            'Note',
            style: AppTypography.medium14(),
          ),
          AppSizes.gapH12,
          AppTextfield(
            hint: 'Enter Note',
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Note" : null;
            },
            textEditingController: _noteController,
          ),

          // Date Section
          AppSizes.gapH24,
          Text(
            'Date',
            style: AppTypography.medium14(),
          ),
          AppSizes.gapH12,
          Row(
            children: [
              Expanded(
                child: AppTextfield(
                  hint: DateFormat('dd/MM/yyyy').format(_date),
                  onTap: () => _showDatePicker(context),
                  readOnly: true,
                ),
              ),
              AppSizes.gapW12,
              Expanded(
                child: AppTextfield(
                  hint: DateFormat('hh:mm a').format(_date),
                  onTap: () => _showTimePicker(context),
                  readOnly: true,
                ),
              ),
            ],
          ),

          // Reminder Section
          AppSizes.gapH24,
          ReminderSection(
            selectedReminder: _reminder,
            onReminderSelected: (value) => setState(() => _reminder = value),
          ),

          // Color Picker Section
          AppSizes.gapH24,
          ColorPickerSection(
            selectedColorIndex: _colorIndex,
            onColorSelected: (value) => setState(() => _colorIndex = value),
          ),

          // Submit Button
          AppSizes.gapH32,
          AppButton(
            color: context.theme.primaryColor,
            width: 1.sw,
            title: widget.initialTask != null ? 'Update Task' : 'Add Task',
            onClick: submitForm,
          ),
        ],
      ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(
        () => _date = DateTime(
          picked.year,
          picked.month,
          picked.day,
          _date.hour,
          _date.minute,
        ),
      );
    }
  }

  void _showTimePicker(BuildContext context) async {
    Navigator.push(
      context,
      showPicker(
        value: Time(hour: _date.hour, minute: _date.minute),
        is24HrFormat: true,
        onChange: (value) => setState(
          () => _date = DateTime(
            _date.year,
            _date.month,
            _date.day,
            value.hour,
            value.minute,
          ),
        ),
      ),
    );
  }

  void submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
        Alerts.of(context).showError('Please fill in all fields');
        return;
      }

      if (_date
          .subtract(Duration(minutes: _reminder))
          .isBefore(DateTime.now())) {
        Alerts.of(context)
            .showError('Please select a date and time after the current date');
        return;
      }

      final task = TaskModel(
        id: widget.initialTask?.id,
        title: _titleController.text,
        note: _noteController.text,
        date: DateFormat('yyyy-MM-dd').format(_date),
        time: DateFormat('hh:mm a').format(_date),
        reminder: _reminder,
        colorIndex: _colorIndex,
      );
      if (widget.initialTask != null) {
        context.read<TaskCubit>().updateTask(task);

        LocalNotificationService().scheduleNotification(
          "Task Reminder",
          "This is a reminder for your task: ${task.title}",
          _date,
          _reminder,
        );
      } else {
        context.read<TaskCubit>().addTask(task);
        LocalNotificationService().scheduleNotification(
          "Task Reminder",
          "This is a reminder for your task: ${task.title}",
          _date,
          _reminder,
        );
      }
    }
  }
}
