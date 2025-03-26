import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:todo_app/core/widgets/app_button.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

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
            return const AppCircularIndicator();
          }

          if (state is! AuthenticationSuccessState) {
            return SafeArea(
              child: Padding(
                padding: AppSizes.defaultPadding,
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
                    AppSizes.gapH48,
                    Text(
                      'Hello !',
                      style: AppTypography.bold32(),
                    ),
                    AppSizes.gapH24,
                    Text(
                      'Welcome to the best Task manager baby !',
                      textAlign: TextAlign.center,
                      style: AppTypography.medium20(),
                    ),
                    AppSizes.gapH48,
                    AppButton(
                      color: Colors.deepPurple,
                      width: 300.w,
                      title: 'Login',
                      func: () {
                        context.pushNamed(RouteNames.loginpage);
                      },
                    ),
                    AppSizes.gapH12,
                    AppButton(
                      color: Colors.deepPurple,
                      width: 300.w,
                      title: 'Sign Up',
                      func: () {
                        context.pushNamed(RouteNames.signuppage);
                      },
                    ),
                    AppSizes.gapH24,
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
      width: 300.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: Colors.deepPurple, width: 2)),
      child: MaterialButton(
        onPressed: () {
          cubit.signinanonym();
        },
        child: Center(
          child: Text(
            'Login as Guest',
            style: AppTypography.medium14(color: Colors.deepPurple),
          ),
        ),
      ),
    );
  }
}
