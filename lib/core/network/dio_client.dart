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
          ? 'http://10.0.2.2:3001/api/'
          : 'http://localhost:3001/api/',
      contentType: 'application/json',
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: _onRequest,
        onError: _onError,
      ),
    );

  static Dio get instance => _dio;

  // Flag to prevent infinite refresh attempts
  static bool _isRefreshing = false;

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

  static Future<String?> _getRefreshToken() async {
    final storage = getIt<SecureStorageService>();
    final refreshToken = await storage.read('refresh_token');

    if (refreshToken != null && refreshToken.isNotEmpty) {
      return refreshToken;
    }

    return null;
  }

  static Future<bool> _refreshToken() async {
    try {
      if (_isRefreshing) return false;
      _isRefreshing = true;

      final refreshToken = await _getRefreshToken();
      if (refreshToken == null) return false;

      final response = await Dio(BaseOptions(
        baseUrl: _dio.options.baseUrl,
        contentType: 'application/json',
      )).post('auth/refresh', data: {'refreshToken': refreshToken});

      if (response.statusCode == 200 && response.data != null) {
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];

        // Store the new tokens
        final storage = getIt<SecureStorageService>();
        await storage.write('access_token', newAccessToken);
        await storage.write('refresh_token', newRefreshToken);

        _isRefreshing = false;
        return true;
      }

      _isRefreshing = false;
      return false;
    } catch (e) {
      debugPrint('Token refresh failed: $e');
      _isRefreshing = false;
      return false;
    }
  }

  static Future<Response<dynamic>> _retryRequest(
      RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    final token = await _getValidToken();
    if (token != null) {
      options.headers?['Authorization'] = 'Bearer $token';
    }

    return _dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  static Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('ERROR[${err.response?.statusCode}] => ${err.message}');

    if (err.response?.statusCode == 401 &&
        !_isAuthRoute(err.requestOptions.path)) {
      // Try to refresh the token
      final isRefreshed = await _refreshToken();

      if (isRefreshed) {
        // Retry the original request with new token
        try {
          final response = await _retryRequest(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          debugPrint('Request retry failed after token refresh: $e');
        }
      }

      // If refresh failed or retry failed, proceed with logout
      await _logout();
    }

    handler.next(err);
  }

  static bool _isAuthRoute(String path) {
    return path.contains('auth/login') ||
        path.contains('auth/register') ||
        path.contains('auth/refresh');
  }

  static Future<void> _logout() async {
    debugPrint('Logging out due to authentication failure');
    await getIt<SecureStorageService>().deleteAll();
    getIt<CacheService>().setBool(CacheKeys.isLogged, false);

    final context = AppRouter.rootNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      context.goNamed(RouteNames.loginpage);
    }
  }
}
