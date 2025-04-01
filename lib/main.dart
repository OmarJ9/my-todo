import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/core/di/dependency_injection.dart';
import 'package:todo_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/features/auth/blocs/authentication/authentication_cubit.dart';
import 'package:todo_app/features/auth/blocs/sign_up_form/sign_up_form_cubit.dart';
import 'package:todo_app/features/task/blocs/task/task_cubit.dart';
import 'package:todo_app/features/profile/cubit/profile_cubit.dart';

import 'core/services/local_notifications_service.dart';
import 'core/theme/theme_cubit.dart';
import 'features/auth/blocs/login_form/login_form_cubit.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  tz.initializeTimeZones();

  await LocalNotificationService().init();

  final storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  HydratedBloc.storage = storage;

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
        // For bigger apps, you should not define them globally. Since this is a small app, I'm defining them globally.
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => OnboardingCubit(),
            ),
            BlocProvider(
              create: (context) => getIt<AuthenticationCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<TaskCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<ProfileCubit>(),
            ),
            BlocProvider(
              create: (context) => ThemeCubit(),
            ),
            BlocProvider(
              create: (context) => LoginFormCubit(),
            ),
            BlocProvider(
              create: (context) => SignUpFormCubit(),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeData>(
            builder: (context, state) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Todo App',
                themeMode: ThemeMode.light,
                theme: state,
                routerConfig: AppRouter().router,
              );
            },
          ),
        );
      },
    );
  }
}
