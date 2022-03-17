import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/repositories/firestore_crud.dart';
import 'package:todo_app/presentation/widgets/mybutton.dart';
import 'package:todo_app/presentation/widgets/mytextfield.dart';
import 'package:todo_app/shared/constants/consts_variables.dart';
import 'package:todo_app/shared/styles/colors.dart';

import '../../shared/services/notification_service.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? task;

  const AddTaskScreen({
    this.task,
    Key? key,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  get isEditMote => widget.task != null;

  late TextEditingController _titlecontroller;
  late TextEditingController _notecontroller;
  late DateTime currentdate;
  static var _starthour = TimeOfDay.now();

  var endhour = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();
  late int _selectedReminder;
  late int _selectedcolor;

  List<DropdownMenuItem<int>> menuItems = const [
    DropdownMenuItem(
        child: Text(
          "5 Min Earlier",
        ),
        value: 5),
    DropdownMenuItem(
        child: Text(
          "10 Min Earlier",
        ),
        value: 10),
    DropdownMenuItem(
        child: Text(
          "15 Min Earlier",
        ),
        value: 15),
    DropdownMenuItem(
        child: Text(
          "20 Min Earlier",
        ),
        value: 20),
  ];

  @override
  void initState() {
    super.initState();
    _titlecontroller =
        TextEditingController(text: isEditMote ? widget.task!.title : '');
    _notecontroller =
        TextEditingController(text: isEditMote ? widget.task!.note : '');

    currentdate =
        isEditMote ? DateTime.parse(widget.task!.date) : DateTime.now();
    endhour = TimeOfDay(
      hour: _starthour.hour + 1,
      minute: _starthour.minute,
    );
    _selectedReminder = isEditMote ? widget.task!.reminder : 5;
    _selectedcolor = isEditMote ? widget.task!.colorindex : 0;
  }

  @override
  void dispose() {
    super.dispose();
    _titlecontroller.dispose();
    _notecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _buildform(context),
          ),
        ),
      ),
    );
  }

  Form _buildform(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 1.h,
          ),
          _buildAppBar(context),
          SizedBox(
            height: 3.h,
          ),
          Text(
            'Title',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          MyTextfield(
            hint: 'Enter Title',
            icon: Icons.title,
            showicon: false,
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Title" : null;
            },
            textEditingController: _titlecontroller,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Note',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          MyTextfield(
            hint: 'Enter Note',
            icon: Icons.ac_unit,
            showicon: false,
            maxlenght: 40,
            validator: (value) {
              return value!.isEmpty ? "Please Enter A Note" : null;
            },
            textEditingController: _notecontroller,
          ),
          Text(
            'Date',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          MyTextfield(
            hint: DateFormat('dd/MM/yyyy').format(currentdate),
            icon: Icons.calendar_today,
            readonly: true,
            showicon: false,
            validator: (value) {},
            ontap: () {
              _showdatepicker();
            },
            textEditingController: TextEditingController(),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Start Time',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    MyTextfield(
                      hint: DateFormat('HH:mm a').format(DateTime(
                          0, 0, 0, _starthour.hour, _starthour.minute)),
                      icon: Icons.watch_outlined,
                      showicon: false,
                      readonly: true,
                      validator: (value) {},
                      ontap: () {
                        Navigator.push(
                            context,
                            showPicker(
                              value: _starthour,
                              is24HrFormat: true,
                              accentColor: Colors.deepPurple,
                              onChange: (TimeOfDay newvalue) {
                                setState(() {
                                  _starthour = newvalue;
                                  endhour = TimeOfDay(
                                    hour: _starthour.hour < 22
                                        ? _starthour.hour + 1
                                        : _starthour.hour,
                                    minute: _starthour.minute,
                                  );
                                });
                              },
                            ));
                      },
                      textEditingController: TextEditingController(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 4.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'End Time',
                      style: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(fontSize: 14.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    MyTextfield(
                      hint: DateFormat('HH:mm a').format(
                          DateTime(0, 0, 0, endhour.hour, endhour.minute)),
                      icon: Icons.watch,
                      showicon: false,
                      readonly: true,
                      validator: (value) {},
                      ontap: () {
                        Navigator.push(
                            context,
                            showPicker(
                              value: endhour,
                              is24HrFormat: true,
                              minHour: _starthour.hour.toDouble() - 1,
                              accentColor: Colors.deepPurple,
                              onChange: (TimeOfDay newvalue) {
                                setState(() {
                                  endhour = newvalue;
                                });
                              },
                            ));
                      },
                      textEditingController: TextEditingController(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Reminder',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          _buildDropdownButton(context),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Colors',
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 14.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: List<Widget>.generate(
                    3,
                    (index) => Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedcolor = index;
                              });
                            },
                            child: CircleAvatar(
                                backgroundColor: colors[index],
                                child: _selectedcolor == index
                                    ? const Icon(
                                        Icons.done,
                                        color: Appcolors.white,
                                      )
                                    : null),
                          ),
                        )),
              ),
              MyButton(
                color: isEditMote ? Colors.green : Colors.deepPurple,
                width: 40.w,
                title: isEditMote ? "Update Task" : 'Create Task',
                func: () {
                  _addtask();
                },
              )
            ],
          )
        ],
      ),
    );
  }

  _addtask() {
    if (_formKey.currentState!.validate()) {
      TaskModel task = TaskModel(
        title: _titlecontroller.text,
        note: _notecontroller.text,
        date: DateFormat('yyyy-MM-dd').format(currentdate),
        starttime: _starthour.format(context),
        endtime: endhour.format(context),
        reminder: _selectedReminder,
        colorindex: _selectedcolor,
        id: '',
      );
      isEditMote
          ? FireStoreCrud().updateTask(
              docid: widget.task!.id,
              title: _titlecontroller.text,
              note: _notecontroller.text,
              date: DateFormat('yyyy-MM-dd').format(currentdate),
              starttime: _starthour,
              endtime: endhour.format(context),
              reminder: _selectedReminder,
              colorindex: _selectedcolor,
            )
          : FireStoreCrud().addTask(task: task);

      NotificationsHandler.createScheduledNotification(
        date: currentdate.day,
        hour: _starthour.hour,
        minute: _starthour.minute - _selectedReminder,
        title: '${Emojis.time_watch} It Is Time For Your Task!!!',
        body: _titlecontroller.text,
      );

      NotificationsHandler.createScheduledNotification(
        date: currentdate.day,
        hour: endhour.hour,
        minute: endhour.minute - _selectedReminder,
        title: '${Emojis.time_watch} Your task ends now!!!',
        body: _titlecontroller.text,
      );

      Navigator.pop(context);
    }
  }

  DropdownButtonFormField<int> _buildDropdownButton(BuildContext context) {
    return DropdownButtonFormField(
      value: _selectedReminder,
      items: menuItems,
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(fontSize: 9.sp, color: Colors.deepPurple),
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.deepPurple,
        size: 25.sp,
      ),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade200,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 0,
            )),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      ),
      onChanged: (int? val) {
        setState(() {
          _selectedReminder = val!;
        });
      },
    );
  }

  _showdatepicker() async {
    var selecteddate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
      currentDate: DateTime.now(),
    );
    setState(() {
      selecteddate != null ? currentdate = selecteddate : null;
    });
  }

  Row _buildAppBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left,
            size: 30.sp,
          ),
        ),
        Text(
          isEditMote ? 'Update Task' : 'Add Task',
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox()
      ],
    );
  }
}
