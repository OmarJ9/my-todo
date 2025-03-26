import 'package:flutter/material.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/features/onboarding/widgets/onboard_item.dart';

import '../../../core/theme/app_colors.dart';
import 'onboarding_custom_painter.dart';

class OnboardingContent extends StatelessWidget {
  final PageController pageController;

  const OnboardingContent({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: CustomPaint(
        painter: OnboardingCustomPainter(color: Appcolors.white),
        child: PageView(
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
              description: 'Track Your Activities And Accomplish Your Goals.',
            ),
          ],
        ),
      ),
    );
  }
}
