import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';
import 'package:todo_app/core/di/dependency_injection.dart';
import 'package:todo_app/core/route/app_router.dart';
import 'package:todo_app/core/services/secure_storage_service.dart';
import 'package:todo_app/core/services/shared_prefs_service.dart';
import 'package:todo_app/core/constants/app_sizes.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_app/core/utils/extensions.dart';
import 'package:todo_app/core/widgets/app_circular_indicator.dart';

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
          await getIt.get<SecureStorageService>().read(CacheKeys.accessToken);
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
            FadeInDown(
              duration: const Duration(milliseconds: 1200),
              child: ZoomIn(
                duration: const Duration(milliseconds: 1500),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: context.theme.primaryColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    BoxIcons.bx_task,
                    size: 80,
                    color: context.theme.primaryColor,
                  ),
                ),
              ),
            ),
            AppSizes.gapH64,
            FadeIn(
              delay: const Duration(seconds: 1),
              duration: const Duration(milliseconds: 1000),
              child: AppCircularIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}
