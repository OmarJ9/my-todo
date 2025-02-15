import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/constants/consts_variables.dart';
import 'package:todo_app/core/route/app_router.dart';

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
      final isLoggedin = FirebaseAuth.instance.currentUser != null;
      final prefs = await SharedPreferences.getInstance();
      final bool? seen = prefs.getBool('seen');
      profileimagesindex = prefs.getInt('pIndex') ?? 0;

      if (isLoggedin) {
        if (mounted) context.go(RouteNames.homepage);
      } else {
        if (seen == true) {
          if (mounted) context.go(RouteNames.loginpage);
        } else {
          if (mounted) context.go(RouteNames.onboarding);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
