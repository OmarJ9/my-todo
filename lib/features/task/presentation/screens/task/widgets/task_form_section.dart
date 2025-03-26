import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/widgets/app_textfield.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

class TaskFormSection extends StatefulWidget {
  final String? initialTitle;
  final String? initialNote;
  final DateTime? initialDate;
  final TimeOfDay? initialStartTime;
  final TimeOfDay? initialEndTime;
  final int? initialReminder;
  final int? initialColorIndex;
  final Function(String) onTitleChanged;
  final Function(String) onNoteChanged;
  final Function(DateTime) onDateChanged;
  final Function(TimeOfDay) onStartTimeChanged;
  final Function(TimeOfDay) onEndTimeChanged;
  final Function(int) onReminderChanged;
  final Function(int) onColorChanged;

  const TaskFormSection({
    super.key,
    this.initialTitle,
    this.initialNote,
    this.initialDate,
    this.initialStartTime,
    this.initialEndTime,
    this.initialReminder,
    this.initialColorIndex,
    required this.onTitleChanged,
    required this.onNoteChanged,
    required this.onDateChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onReminderChanged,
    required this.onColorChanged,
  });

  @override
  State<TaskFormSection> createState() => _TaskFormSectionState();
}

class _TaskFormSectionState extends State<TaskFormSection> {
  late TextEditingController _titlecontroller;
  late TextEditingController _notecontroller;
  late DateTime currentdate;
  late TimeOfDay _starthour;
  late TimeOfDay endhour;

  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<int>> menuItems = const [
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
  ];

  @override
  void initState() {
    super.initState();
    _titlecontroller = TextEditingController(text: widget.initialTitle ?? '');
    _notecontroller = TextEditingController(text: widget.initialNote ?? '');
    currentdate = widget.initialDate ?? DateTime.now();
    _starthour = widget.initialStartTime ?? TimeOfDay.now();
    endhour = widget.initialEndTime ??
        TimeOfDay(
          hour: _starthour.hour + 1,
          minute: _starthour.minute,
        );
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _notecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSizes.gapH12,
          Text(
            'Title',
            style: AppTypography.medium14(),
          ),
          AppSizes.gapH12,
          AppTextfield(
            hint: 'Enter Title',
            icon: Icons.title,
            showicon: false,
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Title" : null;
            },
            textEditingController: _titlecontroller,
            onChanged: widget.onTitleChanged,
          ),
          AppSizes.gapH24,
          Text(
            'Note',
            style: AppTypography.medium14(),
          ),
          AppSizes.gapH12,
          AppTextfield(
            hint: 'Enter Note',
            icon: Icons.ac_unit,
            showicon: false,
            maxlenght: 40,
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Note" : null;
            },
            textEditingController: _notecontroller,
            onChanged: widget.onNoteChanged,
          ),
          Text(
            'Date',
            style: AppTypography.medium14(),
          ),
          AppSizes.gapH12,
          AppTextfield(
            hint: DateFormat('dd/MM/yyyy').format(currentdate),
            icon: Icons.calendar_today,
            readonly: true,
            showicon: false,
            validator: (value) => null,
            ontap: () => _showDatePicker(),
            textEditingController: TextEditingController(),
          ),
          AppSizes.gapH24,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Time',
                      style: AppTypography.medium14(),
                    ),
                    AppSizes.gapH12,
                    AppTextfield(
                      hint: DateFormat('HH:mm a').format(
                        DateTime(0, 0, 0, _starthour.hour, _starthour.minute),
                      ),
                      icon: Icons.watch_outlined,
                      showicon: false,
                      readonly: true,
                      validator: (value) => null,
                      ontap: () => _showStartTimePicker(),
                      textEditingController: TextEditingController(),
                    ),
                  ],
                ),
              ),
              AppSizes.gapW12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'End Time',
                      style: AppTypography.medium14(),
                    ),
                    AppSizes.gapH12,
                    AppTextfield(
                      hint: DateFormat('HH:mm a').format(
                        DateTime(0, 0, 0, endhour.hour, endhour.minute),
                      ),
                      icon: Icons.watch,
                      showicon: false,
                      readonly: true,
                      validator: (value) => null,
                      ontap: () => _showEndTimePicker(),
                      textEditingController: TextEditingController(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentdate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != currentdate) {
      setState(() {
        currentdate = picked;
      });
      widget.onDateChanged(picked);
    }
  }

  void _showStartTimePicker() {
    Navigator.push(
      context,
      showPicker(
        value: Time.fromTimeOfDay(_starthour, null),
        is24HrFormat: true,
        accentColor: Colors.deepPurple,
        onChange: (TimeOfDay newvalue) {
          setState(() {
            _starthour = newvalue;
            endhour = TimeOfDay(
              hour:
                  _starthour.hour < 22 ? _starthour.hour + 1 : _starthour.hour,
              minute: _starthour.minute,
            );
          });
          widget.onStartTimeChanged(newvalue);
          widget.onEndTimeChanged(endhour);
        },
      ),
    );
  }

  void _showEndTimePicker() {
    Navigator.push(
      context,
      showPicker(
        value: Time.fromTimeOfDay(endhour, null),
        is24HrFormat: true,
        minHour: _starthour.hour.toDouble() - 1,
        accentColor: Colors.deepPurple,
        onChange: (TimeOfDay newvalue) {
          setState(() {
            endhour = newvalue;
          });
          widget.onEndTimeChanged(newvalue);
        },
      ),
    );
  }
}
