import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/network/api_service.dart';
import 'package:todo_app/features/auth/data/data_sources/auth_remote_data_source.dart';

import '../network/dio_client.dart';

@module
abstract class DepedencyModule {
  @lazySingleton
  Dio get dio => DioClient.instance;

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  ApiService get apiService => ApiService(dio);

  @lazySingleton
  IAuthRemoteDataSource get authRemoteDataSource => IAuthRemoteDataSource(dio);
}
