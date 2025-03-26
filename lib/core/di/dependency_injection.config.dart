// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:todo_app/core/di/depedency_module.dart' as _i165;
import 'package:todo_app/core/network/api_service.dart' as _i1064;
import 'package:todo_app/core/services/secure_storage_service.dart' as _i533;
import 'package:todo_app/core/services/shared_prefs_service.dart' as _i135;
import 'package:todo_app/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i819;
import 'package:todo_app/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i505;
import 'package:todo_app/features/auth/data/repository/auth_repository.dart'
    as _i766;
import 'package:todo_app/features/auth/presentation/cubit/authentication_cubit.dart'
    as _i862;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final depedencyModule = _$DepedencyModule();
    gh.lazySingleton<_i361.Dio>(() => depedencyModule.dio);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => depedencyModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i1064.ApiService>(() => depedencyModule.apiService);
    gh.lazySingleton<_i505.IAuthRemoteDataSource>(
        () => depedencyModule.authRemoteDataSource);
    gh.lazySingleton<_i533.SecureStorageService>(
        () => const _i533.SecureStorageService());
    gh.lazySingleton<_i135.CacheService>(
        () => _i135.CacheService(gh<_i460.SharedPreferences>()));
    gh.lazySingleton<_i819.IAuthLocalDataSource>(
        () => _i819.AuthLocalDataSource(
              gh<_i533.SecureStorageService>(),
              gh<_i135.CacheService>(),
            ));
    gh.lazySingleton<_i766.IAuthRepository>(() => _i766.AuthRepository(
          gh<_i505.IAuthRemoteDataSource>(),
          gh<_i819.IAuthLocalDataSource>(),
        ));
    gh.factory<_i862.AuthenticationCubit>(
        () => _i862.AuthenticationCubit(gh<_i766.IAuthRepository>()));
    return this;
  }
}

class _$DepedencyModule extends _i165.DepedencyModule {}
