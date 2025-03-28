import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/features/auth/blocs/authentication/authentication_cubit.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

import '../../core/route/app_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 5,
                      child: FadeInDown(
                        duration: const Duration(milliseconds: 1200),
                        child: Image.asset(
                          AppAssets.welcomesketch,
                          fit: BoxFit.contain,
                          height: size.height * 0.4,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 300),
                            child: Text(
                              'Task Management',
                              style: AppTypography.bold32().copyWith(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                          AppSizes.gapH16,
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 400),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                'Organize your tasks efficiently and boost your productivity',
                                textAlign: TextAlign.center,
                                style: AppTypography.medium16().copyWith(
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                          AppSizes.gapH32,
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 500),
                            child: _buildPrimaryButton(
                              context: context,
                              label: 'Sign In',
                              onPressed: () =>
                                  context.pushNamed(RouteNames.loginpage),
                              isPrimary: true,
                            ),
                          ),
                          AppSizes.gapH16,
                          FadeInUp(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 600),
                            child: _buildPrimaryButton(
                              context: context,
                              label: 'Create Account',
                              onPressed: () =>
                                  context.pushNamed(RouteNames.signuppage),
                              isPrimary: false,
                            ),
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildPrimaryButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? Colors.deepPurple : Colors.white,
          foregroundColor: isPrimary ? Colors.white : Colors.deepPurple,
          elevation: isPrimary ? 2 : 0,
          shadowColor: isPrimary
              ? Colors.deepPurple.withOpacity(0.4)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: isPrimary ? Colors.transparent : Colors.deepPurple,
              width: 1.5,
            ),
          ),
        ),
        child: Text(
          label,
          style: AppTypography.medium16().copyWith(
            color: isPrimary ? Colors.white : Colors.deepPurple,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
