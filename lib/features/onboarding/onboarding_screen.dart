import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:todo_app/features/onboarding/widgets/onboarding_content.dart';
import 'package:todo_app/features/onboarding/widgets/onboarding_navigation.dart';

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
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          OnboardingCubit cubit = BlocProvider.of(context);
          return Column(
            children: [
              OnboardingContent(pageController: _pageController),
              OnboardingNavigation(
                pageController: _pageController,
                cubit: cubit,
              ),
            ],
          );
        },
      ),
    );
  }
}
