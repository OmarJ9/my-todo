import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/secure_storage_service.dart';
import '../di/dependency_injection.dart';
import '../route/app_router.dart';
import '../services/shared_prefs_service.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      baseUrl: Platform.isAndroid
          ? 'http://10.0.2.2:3000/api/v1'
          : 'http://localhost:3000/api/v1',
      contentType: 'application/json',
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );

  static Dio get instance => _dio;

  static Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    if (!_isAuthRoute(options.path)) {
      final token = await _getValidToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  static Future<String?> _getValidToken() async {
    final storage = getIt<SecureStorageService>();
    final token = await storage.read('access_token');

    if (token != null && token.isNotEmpty) {
      return token;
    }

    return null;
  }

  static Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('ERROR[${err.response?.statusCode}] => ${err.message}');

    if (err.response?.statusCode == 401) {
      await _logout();
    }

    handler.next(err);
  }

  static bool _isAuthRoute(String path) {
    return path.contains('auth/login') || path.contains('auth/register');
  }

  static Future<void> _logout() async {
    debugPrint(
        'Logging out due to authentication failure. here is the full login endpoint: ${_dio.options.baseUrl}/auth/login');
    await getIt<SecureStorageService>().deleteAll();
    getIt<CacheService>().setBool(CacheKeys.isLogged, false);

    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      context.goNamed(RouteNames.loginpage);
    }
  }
}
