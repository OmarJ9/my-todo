import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_exception.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/sign_up_request_model.dart';
import '../../../../core/models/user_model.dart';

abstract class IAuthRepository {
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserModel>> signup({
    required String username,
    required String email,
    required String password,
  });
  Future<void> logOut();
}

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource _authRemoteDataSource;
  final IAuthLocalDataSource _authLocalDataSource;

  AuthRepository(
    this._authRemoteDataSource,
    this._authLocalDataSource,
  );

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authRemoteDataSource.login(
        LoginRequestBody(
          email: email,
          password: password,
        ),
      );
      await _authLocalDataSource.saveTokens(
        response.accessToken ?? '',
        response.refreshToken ?? '',
      );

      await _authLocalDataSource.saveIsLogged();

      if (response.user == null) {
        return left(
            ServerFailure(errorMessage: "User data is missing from response"));
      }

      return right(response.user!);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _authRemoteDataSource.signup(
        SignUpRequestBody(
          username: username,
          email: email,
          password: password,
        ),
      );
      await _authLocalDataSource.saveTokens(
        response.accessToken ?? '',
        response.refreshToken ?? '',
      );

      await _authLocalDataSource.saveIsLogged();

      if (response.user == null) {
        return left(
            ServerFailure(errorMessage: "User data is missing from response"));
      }

      return right(response.user!);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong"));
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _authRemoteDataSource.logOut();
      await _authLocalDataSource.deleteTokens();
    } catch (e) {
      throw "Something went wrong";
    }
  }
}
