import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/network/dio_exception.dart';
import '../data_sources/profile_remote_data_source.dart';
import '../models/user_model.dart';

abstract class IProfileRepository {
  Future<Either<Failure, UserModel>> getProfile();
  Future<Either<Failure, UserModel>> updateProfile(UserModel user);
}

@LazySingleton(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  final IProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepository(this._profileRemoteDataSource);

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      final response = await _profileRemoteDataSource.getProfile();

      // Validate response data
      if (response.username == null && response.avatarIndex == null) {
        return left(
            ServerFailure(errorMessage: "Invalid profile data received"));
      }

      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(
          ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(UserModel user) async {
    try {
      // Log what we're sending for debugging
      print("Updating profile with: ${user.toString()}");

      final updatedUser = await _profileRemoteDataSource.updateProfile(user);

      // Log what we received back
      print("Server response: ${updatedUser.toString()}");

      return right(updatedUser);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      print("DioException updating profile: ${errorMessage.message}");
      print("Request data: ${e.requestOptions.data}");
      if (e.response != null) {
        print("Response data: ${e.response?.data}");
      }
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      print("Error updating profile: ${e.toString()}");
      return left(
          ServerFailure(errorMessage: "Something went wrong: ${e.toString()}"));
    }
  }
}
