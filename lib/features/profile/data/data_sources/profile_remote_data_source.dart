import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/models/user_model.dart';

part 'profile_remote_data_source.g.dart';

@RestApi()
abstract class IProfileRemoteDataSource {
  factory IProfileRemoteDataSource(Dio dio, {String baseUrl}) =
      _IProfileRemoteDataSource;

  @GET("/me")
  Future<UserModel> getProfile();

  @PUT("/me")
  Future<UserModel> updateProfile(
    @Body() UserModel user,
  );
}
