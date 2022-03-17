import 'package:flutter/material.dart';
import 'package:todo_app/data/models/task_model.dart';
import 'package:todo_app/presentation/screens/addtask_screen.dart';
import 'package:todo_app/presentation/screens/login_page.dart';
import 'package:todo_app/presentation/screens/my_homepage.dart';
import 'package:todo_app/presentation/screens/onboarding.dart';
import 'package:todo_app/presentation/screens/signup_page.dart';
import 'package:todo_app/presentation/screens/welcome_page.dart';
import 'package:todo_app/shared/constants/strings.dart';

class AppRoute {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        {
          return MaterialPageRoute(builder: (_) => const OnboardingPage());
        }

      case welcomepage:
        {
          return MaterialPageRoute(builder: (_) => const WelcomePage());
        }

      case loginpage:
        {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
      case signuppage:
        {
          return MaterialPageRoute(builder: (_) => const SignUpPage());
        }
      case homepage:
        {
          return MaterialPageRoute(builder: (_) => const MyHomePage());
        }
      case addtaskpage:
        {
          final task = settings.arguments as TaskModel?;
          return MaterialPageRoute(
              builder: (_) => AddTaskScreen(
                    task: task,
                  ));
        }
      default:
        throw 'No Page Found!!';
    }
  }
}
