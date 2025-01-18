import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/features/onboarding/presentation/onboarding/onboarding_cubit.dart';
import 'package:todo_app/core/widgets/circular_button.dart';
import 'package:todo_app/features/onboarding/presentation/custom_dots.dart';
import 'package:todo_app/core/widgets/mybutton.dart';
import 'package:todo_app/features/welcome/mycustompainter.dart';
import 'package:todo_app/features/onboarding/presentation/onboarding_item.dart';
import 'package:todo_app/core/constants/consts_variables.dart';
import 'package:todo_app/core/theme/app_colors.dart';

import '../../../core/route/app_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {},
        builder: (context, state) {
          OnboardingCubit cubit = BlocProvider.of(context);
          return SafeArea(
              child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                      width: 100.w,
                      height: 95.h,
                      color: Colors.deepPurple,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn);

                                    cubit.curruntindext > 0
                                        ? cubit.removefromindex()
                                        : null;
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: Text(
                                      'Back',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge
                                          ?.copyWith(
                                            fontSize: 13.sp,
                                            color: Colors.white38,
                                          ),
                                    ),
                                  ),
                                ),
                                CustomDots(myindex: cubit.curruntindext),
                                SizedBox(
                                  width: 10.w,
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    width: 100.w,
                    height: 90.h,
                    child: CustomPaint(
                      painter: const MycustomPainter(color: Appcolors.white),
                      child: SizedBox(
                        width: 80.w,
                        height: 50.h,
                        child: PageView.builder(
                          itemCount: onboardinglist.length,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _pageController,
                          itemBuilder: ((context, index) {
                            return OnBoardingItem(
                              index: index,
                              image: onboardinglist[index].img,
                              title: onboardinglist[index].title,
                              description: onboardinglist[index].description,
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  cubit.curruntindext != onboardinglist.length - 1
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: MyButton(
                                color: Colors.deepPurple,
                                width: 19.w,
                                title: 'Skip',
                                func: () {
                                  _pageController.animateToPage(
                                      onboardinglist.length - 1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeOut);
                                  cubit.curruntindext <
                                          onboardinglist.length - 1
                                      ? cubit.skipindex()
                                      : null;
                                }),
                          ))
                      : Container(),
                  Positioned(
                    bottom: 10.h,
                    child: CircularButton(
                        color: Appcolors.pink.withOpacity(0.6),
                        width: 30.w,
                        icon: Icons.arrow_right_alt_sharp,
                        condition:
                            cubit.curruntindext != onboardinglist.length - 1,
                        func: () {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                          if (cubit.curruntindext < onboardinglist.length - 1) {
                            cubit.changeindex();
                          } else {
                            context.goNamed(RouteNames.welcomepage);
                            cubit.savepref('seen');
                          }
                        }),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
  }
}
