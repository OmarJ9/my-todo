import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/core/widgets/app_circular_button.dart';
import 'package:todo_app/core/theme/app_colors.dart';
import 'package:todo_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:todo_app/features/onboarding/widgets/on_boarding_custom_dots.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:go_router/go_router.dart';

class OnboardingNavigation extends StatelessWidget {
  final PageController pageController;
  final OnboardingCubit cubit;

  const OnboardingNavigation({
    super.key,
    required this.pageController,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .2.sh,
      color: Colors.deepPurple,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomDots(myindex: cubit.curruntindext),
            ],
          ),
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Center(
              child: AppCircularButton(
                color: Appcolors.pink.withOpacity(0.6),
                width: 100.w,
                text: 'Begin',
                icon: Icons.arrow_right_alt_sharp,
                condition: cubit.curruntindext != 2,
                func: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  if (cubit.curruntindext < 2) {
                    cubit.changeindex();
                  } else {
                    context.goNamed(RouteNames.welcomepage);
                    cubit.savepref('seen');
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
