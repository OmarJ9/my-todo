import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/dio_exception.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/login_request_model.dart';
import '../models/sign_up_request_model.dart';

abstract class IAuthRepository {
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, bool>> signup({
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
  Future<Either<Failure, bool>> login({
    required String email,
    required String password,
  }) async {
    try {
      final token = await _authRemoteDataSource.login(
        LoginRequestBody(
          email: email,
          password: password,
        ),
      );
      await _authLocalDataSource.saveTokens(
        token.accessToken,
        token.refreshToken,
      );

      await _authLocalDataSource.saveIsLogged();

      return right(true);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Quelque chose s'est mal passé"));
    }
  }

  @override
  Future<Either<Failure, bool>> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final token = await _authRemoteDataSource.signup(
        SignUpRequestBody(
          usernamename: username,
          email: email,
          password: password,
        ),
      );
      await _authLocalDataSource.saveTokens(
        token.accessToken,
        token.refreshToken,
      );

      await _authLocalDataSource.saveIsLogged();

      return right(true);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(
          ServerFailure(errorMessage: "Quelque chose s'est mal passer"));
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _authRemoteDataSource.logOut();
      await _authLocalDataSource.deleteTokens();
    } catch (e) {
      throw "Quelque chose s'est mal passer";
    }
  }
}
