import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPageIndicator extends StatelessWidget {
  final PageController pageController;
  const OnBoardingPageIndicator({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: 3,
      effect: JumpingDotEffect(
        activeDotColor: Colors.white,
        dotColor: Colors.white54,
        dotHeight: 13.h,
        dotWidth: 13.w,
        spacing: 16.w,
      ),
    );
  }
}
