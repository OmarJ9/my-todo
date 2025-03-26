import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/task/data/models/task_model.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/task_form_section.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/color_picker_section.dart';
import 'package:todo_app/features/task/presentation/screens/task/widgets/reminder_section.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? task;

  const AddTaskScreen({
    this.task,
    super.key,
  });

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  get isEditMode => widget.task != null;

  String _title = '';
  String _note = '';
  DateTime _date = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay(
    hour: TimeOfDay.now().hour + 1,
    minute: TimeOfDay.now().minute,
  );
  int _reminder = 5;
  int _colorIndex = 0;

  @override
  void initState() {
    super.initState();
    if (isEditMode) {
      _title = widget.task!.title;
      _note = widget.task!.note;
      _date = DateTime.parse(widget.task!.date);
      _startTime = TimeOfDay(
        hour: int.parse(widget.task!.starttime.split(':')[0]),
        minute: int.parse(widget.task!.starttime.split(':')[1]),
      );
      _endTime = TimeOfDay(
        hour: int.parse(widget.task!.endtime.split(':')[0]),
        minute: int.parse(widget.task!.endtime.split(':')[1]),
      );
      _reminder = widget.task!.reminder;
      _colorIndex = widget.task!.colorindex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: BlocListener<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is TaskAdded || state is TaskUpdated) {
            Navigator.pop(context);
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
                    initialStartTime: _startTime,
                    initialEndTime: _endTime,
                    initialReminder: _reminder,
                    initialColorIndex: _colorIndex,
                    onTitleChanged: (value) => _title = value,
                    onNoteChanged: (value) => _note = value,
                    onDateChanged: (value) => _date = value,
                    onStartTimeChanged: (value) => _startTime = value,
                    onEndTimeChanged: (value) => _endTime = value,
                    onReminderChanged: (value) => _reminder = value,
                    onColorChanged: (value) => _colorIndex = value,
                  ),
                  AppSizes.gapH24,
                  ColorPickerSection(
                    selectedColorIndex: _colorIndex,
                    onColorSelected: (value) => _colorIndex = value,
                  ),
                  AppSizes.gapH24,
                  ReminderSection(
                    selectedReminder: _reminder,
                    onReminderSelected: (value) => _reminder = value,
                  ),
                  AppSizes.gapH32,
                  AppButton(
                    color: Colors.deepPurple,
                    width: 1.sw,
                    title: isEditMode ? 'Update Task' : 'Add Task',
                    func: () => _handleSubmit(context),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final task = TaskModel(
      id: isEditMode ? widget.task!.id : DateTime.now().toString(),
      title: _title,
      note: _note,
      date: DateFormat('yyyy-MM-dd').format(_date),
      starttime: '${_startTime.hour}:${_startTime.minute}',
      endtime: '${_endTime.hour}:${_endTime.minute}',
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
