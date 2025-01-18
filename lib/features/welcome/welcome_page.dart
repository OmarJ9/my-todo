import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/features/auth/presentation/auth/authentication_cubit.dart';
import 'package:todo_app/core/widgets/mybutton.dart';
import 'package:todo_app/core/widgets/myindicator.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/theme/colors.dart';

import '../../core/route/app_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationCubit authcubit = BlocProvider.of(context);
    return Scaffold(
      backgroundColor: Appcolors.white,
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BounceInDown(
                      duration: const Duration(milliseconds: 1500),
                      child: Image.asset(
                        AppAssets.welcomesketch,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Hello !',
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge
                          ?.copyWith(letterSpacing: 3),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Welcome to the best Task manager baby !',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            letterSpacing: 3,
                            fontSize: 15,
                            wordSpacing: 2,
                          ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    MyButton(
                      color: Colors.deepPurple,
                      width: 80.w,
                      title: 'Login',
                      func: () {
                        context.pushNamed(RouteNames.loginpage);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    MyButton(
                      color: Colors.deepPurple,
                      width: 80.w,
                      title: 'Sign Up',
                      func: () {
                        context.pushNamed(RouteNames.signuppage);
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    _myOutlinedButton(context, authcubit),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Container _myOutlinedButton(
    BuildContext context,
    AuthenticationCubit cubit,
  ) {
    return Container(
      width: 80.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: Colors.deepPurple, width: 2)),
      child: MaterialButton(
        onPressed: () {
          cubit.signinanonym();
        },
        child: Center(
          child: Text(
            'Register Later',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 13,
                  color: Colors.deepPurple,
                ),
          ),
        ),
      ),
    );
  }
}
