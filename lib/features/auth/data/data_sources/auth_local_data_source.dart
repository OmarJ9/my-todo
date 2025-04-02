import 'package:injectable/injectable.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/services/shared_prefs_service.dart';

abstract class IAuthLocalDataSource {
  Future<void> saveTokens(String accessToken);

  Future<void> saveIsLogged();

  Future<void> deleteTokens();
}

@LazySingleton(as: IAuthLocalDataSource)
class AuthLocalDataSource implements IAuthLocalDataSource {
  final SecureStorageService _secureStorageService;
  final CacheService _cacheService;

  AuthLocalDataSource(
    this._secureStorageService,
    this._cacheService,
  );

  @override
  Future<void> saveTokens(String accessToken) async {
    try {
      await _secureStorageService.deleteAll();
      await _secureStorageService.write('access_token', accessToken);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> saveIsLogged() async {
    try {
      await _cacheService.setBool(CacheKeys.isLogged, true);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteTokens() async {
    try {
      await _secureStorageService.deleteAll();

      await _cacheService.setBool(CacheKeys.isLogged, false);
    } catch (_) {
      rethrow;
    }
  }
}
