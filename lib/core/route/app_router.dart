import 'package:go_router/go_router.dart';
import 'package:todo_app/features/splash/splash_screen.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/signup_page.dart';
import '../../features/onboarding/presentation/onboarding.dart';
import '../../features/task/presentation/addtask_screen.dart';
import '../../features/task/presentation/my_homepage.dart';
import '../../features/welcome/welcome_page.dart';

class RouteNames {
  static const String onboarding = "/onboarding";
  static const String welcomepage = "/welcome";
  static const String loginpage = "/login";
  static const String signuppage = "/signup";
  static const String homepage = "/homepage";
  static const String addtaskpage = "/addtask";
}

class AppRouter {
  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: "/",
        builder: (context, state) => const SPlashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteNames.welcomepage,
        name: RouteNames.welcomepage,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: RouteNames.loginpage,
        name: RouteNames.loginpage,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.signuppage,
        name: RouteNames.signuppage,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: RouteNames.homepage,
        name: RouteNames.homepage,
        builder: (context, state) => const MyHomePage(),
      ),
      GoRoute(
        path: RouteNames.addtaskpage,
        name: RouteNames.addtaskpage,
        builder: (context, state) => const AddTaskScreen(),
      ),
    ],
  );
}
// class AppRoute {
//   Route? generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case onboarding:
//         {
//           return MaterialPageRoute(builder: (_) => const OnboardingPage());
//         }

//       case welcomepage:
//         {
//           return MaterialPageRoute(builder: (_) => const WelcomePage());
//         }

//       case loginpage:
//         {
//           return MaterialPageRoute(builder: (_) => const LoginPage());
//         }
//       case signuppage:
//         {
//           return MaterialPageRoute(builder: (_) => const SignUpPage());
//         }
//       case homepage:
//         {
//           return MaterialPageRoute(builder: (_) => const MyHomePage());
//         }
//       case addtaskpage:
//         {
//           final task = settings.arguments as TaskModel?;
//           return MaterialPageRoute(
//               builder: (_) => AddTaskScreen(
//                     task: task,
//                   ));
//         }
//       default:
//         throw 'No Page Found!!';
//     }
//   }
// }
