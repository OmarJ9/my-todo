import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/widgets/app_textfield.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

class TaskFormSection extends StatefulWidget {
  final String? initialTitle;
  final String? initialNote;
  final DateTime? initialDate;

  final int? initialReminder;
  final int? initialColorIndex;
  final Function(String) onTitleChanged;
  final Function(String) onNoteChanged;
  final Function(DateTime) onDateChanged;

  final Function(int) onReminderChanged;
  final Function(int) onColorChanged;

  const TaskFormSection({
    super.key,
    this.initialTitle,
    this.initialNote,
    this.initialDate,
    this.initialReminder,
    this.initialColorIndex,
    required this.onTitleChanged,
    required this.onNoteChanged,
    required this.onDateChanged,
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
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Title" : null;
            },
            textEditingController: _titlecontroller,
            onChange: widget.onTitleChanged,
          ),
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
            textEditingController: _notecontroller,
            onChange: widget.onNoteChanged,
          ),
          AppSizes.gapH24,
          Text(
            'Date',
            style: AppTypography.medium14(),
          ),
          AppSizes.gapH12,
          AppTextfield(
            hint: DateFormat('dd/MM/yyyy').format(currentdate),
            validator: (value) => null,
            onTap: () => _showDatePicker(),
            readOnly: true,
            textEditingController: TextEditingController(),
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
      lastDate:
          DateTime.now().add(const Duration(days: 365 * 5)), // 5 years from now
    );
    if (picked != null && picked != currentdate) {
      setState(() {
        currentdate = picked;
      });
      widget.onDateChanged(picked);
    }
  }
}
