import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:todo_app/features/task/presentation/cubit/task_cubit.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/task/presentation/screens/home/widgets/profile_section.dart';
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

  final TextEditingController _usercontroller =
      TextEditingController(text: 'John Doe');

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
    _usercontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is UnAuthenticationState) {
                context.goNamed(RouteNames.welcomepage);
              }
            },
          )
        ],
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationLoadingState) {
              return const AppCircularIndicator();
            }

            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          color: Colors.deepPurple,
                          width: 150.w,
                          title: '+ Add Task',
                          func: () {
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
                    Expanded(
                      child: TaskListSection(selectedDate: currentdate),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
