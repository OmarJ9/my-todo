import 'package:flutter/material.dart';
import 'package:todo_app/data/models/onboarding_model.dart';
import 'package:todo_app/shared/constants/assets_path.dart';
import 'package:todo_app/shared/styles/colors.dart';

List<OnBoardingModel> onboardinglist = const [
  OnBoardingModel(
    img: MyAssets.onboradingone,
    title: 'Manage Your Task',
    description:
        'With This Small App You Can Orgnize All Your Tasks and Duties In A One Single App.',
  ),
  OnBoardingModel(
    img: MyAssets.onboradingtwo,
    title: 'Plan Your Day',
    description: 'Add A Task And The App Will Remind You.',
  ),
  OnBoardingModel(
    img: MyAssets.onboradingthree,
    title: 'Accomplish Your Goals ',
    description: 'Track Your Activities And Accomplish Your Goals.',
  ),
];

const List<Color> colors = [Appcolors.bleu, Appcolors.pink, Appcolors.yellow];

const List<String> profileimages = [
  MyAssets.profileicon1,
  MyAssets.profileicon2,
  MyAssets.profileicon3,
  MyAssets.profileicon4,
];

int profileimagesindex = 0;
