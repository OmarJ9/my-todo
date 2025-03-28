import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:todo_app/features/onboarding/widgets/onboard_item.dart';
import '../../../core/route/app_router.dart';
import 'onboarding_custom_painter.dart';

class OnboardingContent extends StatelessWidget {
  final PageController pageController;
  final OnboardingCubit cubit;

  const OnboardingContent({
    super.key,
    required this.pageController,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: CustomPaint(
        painter: OnboardingCustomPainter(color: Colors.white),
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                OnBoardItem(
                  image: AppAssets.onboradingone,
                  title: 'Manage Your Task',
                  description:
                      'With This Small App You Can Orgnize All Your Tasks and Duties In A One Single App.',
                ),
                OnBoardItem(
                  image: AppAssets.onboradingtwo,
                  title: 'Plan Your Day',
                  description: 'Add A Task And The App Will Remind You.',
                ),
                OnBoardItem(
                  image: AppAssets.onboradingthree,
                  title: 'Accomplish Your Goals ',
                  description:
                      'Track Your Activities And Accomplish Your Goals.',
                ),
              ],
            ),
            // Circle Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.h),
                child: ElevatedButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                    if (cubit.curruntindext < 2) {
                      cubit.changeindex();
                    } else {
                      context.goNamed(RouteNames.welcomepage);
                      cubit.savepref();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                    minimumSize: Size(50.w, 50.h),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
