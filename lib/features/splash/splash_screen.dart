import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:todo_app/core/di/dependency_injection.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/core/services/secure_storage_service.dart';
import 'package:todo_app/core/services/shared_prefs_service.dart';
import 'package:todo_app/core/theme/app_styles.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:icons_plus/icons_plus.dart';

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
      getIt<CacheService>().deleteAll();
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800,
              Colors.deepPurple.shade500,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 1200),
                child: ZoomIn(
                  duration: const Duration(milliseconds: 1500),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      BoxIcons.bx_task,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              AppSizes.gapH24,
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 1000),
                child: Text(
                  'My Todo',
                  style: AppTypography.bold32(color: Colors.white),
                ),
              ),
              AppSizes.gapH16,
              FadeIn(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 1000),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
