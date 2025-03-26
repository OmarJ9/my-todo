import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/core/theme/app_thems.dart';

import 'features/auth/presentation/cubit/authentication_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
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
          ),
        );
      },
    );
  }
}
