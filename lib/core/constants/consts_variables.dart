import 'package:flutter/material.dart';
import 'package:todo_app/data/models/onboarding_model.dart';
import 'package:todo_app/core/constants/app_assets.dart';
import 'package:todo_app/core/theme/colors.dart';

List<OnBoardingModel> onboardinglist = const [
  OnBoardingModel(
    img: AppAssets.onboradingone,
    title: 'Manage Your Task',
    description:
        'With This Small App You Can Orgnize All Your Tasks and Duties In A One Single App.',
  ),
  OnBoardingModel(
    img: AppAssets.onboradingtwo,
    title: 'Plan Your Day',
    description: 'Add A Task And The App Will Remind You.',
  ),
  OnBoardingModel(
    img: AppAssets.onboradingthree,
    title: 'Accomplish Your Goals ',
    description: 'Track Your Activities And Accomplish Your Goals.',
  ),
];

const List<Color> colors = [Appcolors.bleu, Appcolors.pink, Appcolors.yellow];

const List<String> profileimages = [
  AppAssets.profileicon1,
  AppAssets.profileicon2,
  AppAssets.profileicon3,
  AppAssets.profileicon4,
];

int profileimagesindex = 0;
