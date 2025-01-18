import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/features/auth/presentation/auth/authentication_cubit.dart';
import 'package:todo_app/core/widgets/mybutton.dart';
import 'package:todo_app/core/widgets/myindicator.dart';
import 'package:todo_app/core/widgets/mysnackbar.dart';
import 'package:todo_app/core/widgets/mytextfield.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/theme/colors.dart';
import 'package:todo_app/core/utils/validators.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namecontroller;
  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;

  @override
  void initState() {
    super.initState();
    _namecontroller = TextEditingController();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _namecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit authcubit = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: Appcolors.white,
      appBar: AppBar(
        backgroundColor: Appcolors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: Appcolors.black,
            size: 30,
          ),
        ),
      ),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationErrortate) {
            // Showing the error message if the user has entered invalid credentials
            MySnackBar.error(
                message: state.error.toString(),
                color: Colors.red,
                context: context);
          }

          if (state is AuthenticationSuccessState) {
            context.goNamed(RouteNames.homepage);
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoadingState) {
            return const MyCircularIndicator();
          }
          if (state is! AuthenticationSuccessState) {
            return SafeArea(
                child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: Form(
                  key: _formKey,
                  child: BounceInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Heey !',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                letterSpacing: 2,
                              ),
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'Create a New Account !',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  fontSize: 15,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        MyTextfield(
                          hint: 'Full Name',
                          icon: Icons.person,
                          keyboardtype: TextInputType.name,
                          validator: (value) {
                            return value!.length < 3 ? 'Unvalid Name' : null;
                          },
                          textEditingController: _namecontroller,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        MyTextfield(
                          hint: 'Email Address',
                          icon: Icons.email,
                          keyboardtype: TextInputType.emailAddress,
                          validator: (value) {
                            return !Validators.isValidEmail(value!)
                                ? 'Enter a valid email'
                                : null;
                          },
                          textEditingController: _emailcontroller,
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        MyTextfield(
                          hint: 'Password',
                          icon: Icons.password,
                          obscure: true,
                          keyboardtype: TextInputType.text,
                          validator: (value) {
                            return value!.length < 6
                                ? "Enter min. 6 characters"
                                : null;
                          },
                          textEditingController: _passwordcontroller,
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        MyButton(
                          color: Colors.deepPurple,
                          width: 80.w,
                          title: 'Sign Up',
                          func: () {
                            _signupewithemailandpass(context, authcubit);
                          },
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account ?',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                context.pop();
                              },
                              child: Text(
                                'Login',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      fontSize: 12,
                                      color: Colors.deepPurple,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _myDivider(),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Or',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                    fontSize: 9.sp,
                                    color: Colors.deepPurple,
                                  ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            _myDivider(),
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                authcubit.googleSignIn();
                              },
                              child: Image.asset(
                                AppAssets.googleicon,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'It will be added soon !!',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge
                                        ?.copyWith(
                                            fontSize: 11.sp,
                                            color: Appcolors.white),
                                  ),
                                  backgroundColor: Colors.deepPurple,
                                ));
                              },
                              child: Image.asset(
                                AppAssets.facebookicon,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }
          return Container();
        },
      ),
    );
  }

  Container _myDivider() {
    return Container(
      width: 27.w,
      height: 0.2.h,
      color: Appcolors.black,
    );
  }

  void _signupewithemailandpass(context, AuthenticationCubit cubit) {
    if (_formKey.currentState!.validate()) {
      cubit.register(
          fullname: _namecontroller.text,
          email: _emailcontroller.text,
          password: _passwordcontroller.text);
    }
  }
}
