import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:todo_app/core/utils/extensions.dart';

import '../../core/route/app_router.dart';
import '../../core/widgets/app_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    height: 300.h,
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
                        padding: const EdgeInsets.symmetric(horizontal: 24),
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
                      child: AppButton(
                        width: double.infinity,
                        title: 'Sign In',
                        onClick: () => context.pushNamed(RouteNames.loginpage),
                        color: context.theme.primaryColor,
                        height: 50,
                      ),
                    ),
                    AppSizes.gapH16,
                    FadeInUp(
                      duration: const Duration(milliseconds: 800),
                      delay: const Duration(milliseconds: 600),
                      child: AppButton(
                        width: double.infinity,
                        title: 'Create Account',
                        onClick: () => context.pushNamed(RouteNames.signuppage),
                        color: context.theme.primaryColor,
                        isOutlined: true,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
