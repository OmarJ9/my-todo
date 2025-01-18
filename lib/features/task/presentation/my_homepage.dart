import 'package:animate_do/animate_do.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/features/auth/presentation/auth/authentication_cubit.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/data/repositories/firestore_crud.dart';
import 'package:todo_app/core/widgets/mybutton.dart';
import 'package:todo_app/core/widgets/myindicator.dart';
import 'package:todo_app/core/widgets/mysnackbar.dart';
import 'package:todo_app/core/widgets/mytextfield.dart';
import 'package:todo_app/features/task/presentation/task_container.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/constants/consts_variables.dart';
import 'package:todo_app/core/theme/colors.dart';

import '../../../core/route/app_router.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static var currentdate = DateTime.now();

  final TextEditingController _usercontroller = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName);

  @override
  void dispose() {
    super.dispose();

    _usercontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit authenticationCubit = BlocProvider.of(context);
    final user = FirebaseAuth.instance.currentUser;
    String username = user!.isAnonymous ? 'Anonymous' : 'User';

    return Scaffold(
        body: MultiBlocListener(
            listeners: [
          // BlocListener<ConnectivityCubit, ConnectivityState>(
          //     listener: (context, state) {
          //   if (state is ConnectivityOnlineState) {
          //     MySnackBar.error(
          //         message: 'You Are Online Now ',
          //         color: Colors.green,
          //         context: context);
          //   } else {
          //     MySnackBar.error(
          //         message: 'Please Check Your Internet Connection',
          //         color: Colors.red,
          //         context: context);
          //   }
          // }),
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
                  return const MyCircularIndicator();
                }

                return SafeArea(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // NotificationsHandler.createNotification();
                            },
                            child: SizedBox(
                              height: 8.h,
                              child: Image.asset(
                                profileimages[profileimagesindex],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: Text(
                              user.displayName != null
                                  ? 'Hello ${user.displayName}'
                                  : ' Hello $username',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 15.sp),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _showBottomSheet(context, authenticationCubit);
                            },
                            child: Icon(
                              Icons.settings,
                              size: 25.sp,
                              color: Appcolors.black,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat('MMMM, dd').format(currentdate),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontSize: 17.sp),
                          ),
                          const Spacer(),
                          MyButton(
                            color: Colors.deepPurple,
                            width: 40.w,
                            title: '+ Add Task',
                            func: () {
                              context.pushNamed(RouteNames.addtaskpage);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      _buildDatePicker(context),
                      SizedBox(
                        height: 4.h,
                      ),
                      Expanded(
                          child: StreamBuilder(
                        stream: FireStoreCrud().getTasks(
                          mydate: DateFormat('yyyy-MM-dd').format(currentdate),
                        ),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<TaskModel>> snapshot) {
                          if (snapshot.hasError) {
                            return _nodatawidget();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const MyCircularIndicator();
                          }

                          return snapshot.data!.isNotEmpty
                              ? ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    var task = snapshot.data![index];
                                    Widget taskcontainer = TaskContainer(
                                      id: task.id,
                                      color: colors[task.colorindex],
                                      title: task.title,
                                      starttime: task.starttime,
                                      endtime: task.endtime,
                                      note: task.note,
                                    );
                                    return InkWell(
                                        onTap: () {
                                          context.pushNamed(
                                            RouteNames.addtaskpage,
                                            extra: task,
                                          );
                                        },
                                        child: index % 2 == 0
                                            ? BounceInLeft(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: taskcontainer)
                                            : BounceInRight(
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                                child: taskcontainer));
                                  },
                                )
                              : _nodatawidget();
                        },
                      )),
                    ],
                  ),
                ));
              },
            )));
  }

  Future<dynamic> _showBottomSheet(
      BuildContext context, AuthenticationCubit authenticationCubit) {
    var user = FirebaseAuth.instance.currentUser!.isAnonymous;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StatefulBuilder(
            builder: ((context, setModalState) {
              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (user)
                        ? Container()
                        : Wrap(
                            children: List<Widget>.generate(
                              4,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: InkWell(
                                  onTap: () async {
                                    _updatelogo(index, setModalState);

                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.setInt('plogo', index);
                                  },
                                  child: Container(
                                      height: 8.h,
                                      width: 8.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  profileimages[index]),
                                              fit: BoxFit.cover)),
                                      child: profileimagesindex == index
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.deepPurple,
                                              size: 8.h,
                                            )
                                          : null),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 3.h,
                    ),
                    (user)
                        ? Container()
                        : MyTextfield(
                            hint: '',
                            icon: Icons.person,
                            validator: (value) {
                              return null;
                            },
                            textEditingController: _usercontroller),
                    SizedBox(
                      height: 3.h,
                    ),
                    (user)
                        ? Container()
                        : BlocBuilder<AuthenticationCubit, AuthenticationState>(
                            builder: (context, state) {
                              if (state is UpdateProfileLoadingState) {
                                return const MyCircularIndicator();
                              }

                              return MyButton(
                                color: Colors.green,
                                width: 80.w,
                                title: "Update Profile",
                                func: () {
                                  if (_usercontroller.text == '') {
                                    MySnackBar.error(
                                        message: 'Name shoud not be empty!!',
                                        color: Colors.red,
                                        context: context);
                                  } else {
                                    authenticationCubit.updateUserInfo(
                                        _usercontroller.text, context);
                                    setState(() {});
                                  }
                                },
                              );
                            },
                          ),
                    SizedBox(
                      height: 3.h,
                    ),
                    MyButton(
                      color: Colors.red,
                      width: 80.w,
                      title: "Log Out",
                      func: () {
                        authenticationCubit.signout();
                      },
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  void _updatelogo(int index, void Function(void Function()) setstate) {
    setstate(() {
      profileimagesindex = index;
    });
    setState(() {
      profileimagesindex = index;
    });
  }

  Widget _nodatawidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.clipboard,
            height: 30.h,
          ),
          SizedBox(height: 3.h),
          Text(
            'There Is No Tasks',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  SizedBox _buildDatePicker(BuildContext context) {
    return SizedBox(
      height: 15.h,
      child: DatePicker(
        DateTime.now(),
        width: 20.w,
        initialSelectedDate: DateTime.now(),
        dateTextStyle:
            Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 18),
        dayTextStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: 12, color: Appcolors.black),
        monthTextStyle: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontSize: 12, color: Appcolors.black),
        selectionColor: Colors.deepPurple,
        onDateChange: (DateTime newdate) {
          setState(() {
            currentdate = newdate;
          });
        },
      ),
    );
  }
}
