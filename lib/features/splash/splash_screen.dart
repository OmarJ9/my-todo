import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/core/di/dependency_injection.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/core/services/secure_storage_service.dart';
import 'package:todo_app/core/services/shared_prefs_service.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';

class SPlashScreen extends StatefulWidget {
  const SPlashScreen({super.key});

  @override
  State<SPlashScreen> createState() => _SPlashScreenState();
}

class _SPlashScreenState extends State<SPlashScreen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();
    super.dispose();
  }

  void _startDelay() {
    _timer = Timer(const Duration(seconds: 3), () async {
      final token =
          await getIt.get<SecureStorageService>().read(CacheKeys.refreshToken);
      final isLogged = getIt.get<CacheService>().getBool(CacheKeys.isLogged);

      final onBoardDone =
          getIt.get<CacheService>().getBool(CacheKeys.onBoardingDone);

      if (isLogged && token != null && token.isNotEmpty) {
        if (mounted) context.go(RouteNames.homepage);
      } else {
        if (onBoardDone) {
          if (mounted) context.go(RouteNames.welcomepage);
        } else {
          if (mounted) context.go(RouteNames.onboarding);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            AppSizes.gapH24,
            Text(
              'Loading...',
              style: AppTypography.medium16(),
            ),
          ],
        ),
      ),
    );
  }
}
