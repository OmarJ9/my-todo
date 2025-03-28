import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../services/secure_storage_service.dart';
import '../di/dependency_injection.dart';
import '../route/app_router.dart';
import '../services/shared_prefs_service.dart';
import 'api_service.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
      baseUrl: "http://localhost:3000/api/v1",
      contentType: 'application/json',
      validateStatus: (status) => status! < 500,
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

    if (token != null && !JwtDecoder.isExpired(token)) {
      return token;
    }

    return await _refreshToken();
  }

  static Future<String?> _refreshToken() async {
    debugPrint('Refreshing token...');
    final storage = getIt<SecureStorageService>();
    final refreshToken = await storage.read('refresh_token');

    if (refreshToken == null || JwtDecoder.isExpired(refreshToken)) {
      debugPrint('Refresh token is expired or null');
      await _logout();
      return null;
    }

    try {
      final response =
          await getIt<ApiService>().refreshToken('Bearer $refreshToken');
      print("response of refresh token: $response");
      await _updateTokens(
          response.accessToken ?? '', response.refreshToken ?? '');
      return response.accessToken;
    } catch (e) {
      debugPrint('Token refresh failed: $e');
      await _logout();
      return null;
    }
  }

  static Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    debugPrint('ERROR[${err.response?.statusCode}] => ${err.message}');

    if (err.response?.statusCode == 401 &&
        !_isAuthRoute(err.requestOptions.path)) {
      final newToken = await _refreshToken();
      if (newToken != null) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        final response = await _dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      }
    }

    handler.next(err);
  }

  static Future<void> _updateTokens(
      String accessToken, String refreshToken) async {
    final storage = getIt<SecureStorageService>();
    await Future.wait([
      storage.write('access_token', accessToken),
      storage.write('refresh_token', refreshToken),
    ]);
  }

  static bool _isAuthRoute(String path) {
    return path.contains('auth/login') ||
        path.contains('auth/register') ||
        path.contains('auth/refresh-token');
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
