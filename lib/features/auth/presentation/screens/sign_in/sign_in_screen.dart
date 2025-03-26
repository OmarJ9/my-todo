import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:todo_app/features/auth/presentation/screens/sign_in/widgets/sign_in_form.dart';
import 'package:todo_app/features/auth/presentation/screens/sign_in/widgets/social_sign_in.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/auth_divider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          return SafeArea(
            child: Padding(
              padding: AppSizes.defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back',
                    style: AppTypography.bold24(),
                  ),
                  AppSizes.gapH12,
                  Text(
                    'Login to your account',
                    style: AppTypography.medium14(),
                  ),
                  AppSizes.gapH24,
                  SignInForm(),
                  AppSizes.gapH24,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t Have An Account? ',
                        style: AppTypography.medium14(),
                      ),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RouteNames.signuppage);
                        },
                        child: Text(
                          'Sign Up',
                          style: AppTypography.medium14(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSizes.gapH24,
                  AuthDivider(),
                  AppSizes.gapH24,
                  SocialSignIn(),
                  AppSizes.gapH24,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
