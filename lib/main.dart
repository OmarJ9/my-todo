import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_app/features/onboarding/presentation/onboarding/onboarding_cubit.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/features/task/presentation/my_homepage.dart';
import 'package:todo_app/features/onboarding/presentation/onboarding.dart';
import 'package:todo_app/features/welcome/welcome_page.dart';
import 'package:todo_app/core/widgets/myindicator.dart';
import 'package:todo_app/core/constants/consts_variables.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/core/theme/app_thems.dart';

import 'features/auth/presentation/auth/authentication_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final prefs = await SharedPreferences.getInstance();
  final bool? seen = prefs.getBool('seen');
  profileimagesindex = prefs.getInt('plogo') ?? 0;
  runApp(
    MyApp(
      seen: seen,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.seen});

  final bool? seen;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => OnboardingCubit(),
            ),
            BlocProvider(create: (context) => AuthenticationCubit()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            themeMode: ThemeMode.light,
            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
            routerConfig: AppRouter().router,
            // home: StreamBuilder<User?>(
            //   stream: FirebaseAuth.instance.authStateChanges(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const MyCircularIndicator();
            //     }
            //     if (snapshot.hasData) {
            //       return const MyHomePage();
            //     }
            //     if (seen != null) {
            //       return const WelcomePage();
            //     }
            //     return const OnboardingPage();
            //   },
            // ),
          ),
        );
      },
    );
  }
}
