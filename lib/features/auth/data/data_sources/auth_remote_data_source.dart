import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/login_request_model.dart';
import '../models/sign_up_request_model.dart';
import '../models/auth_response_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class IAuthRemoteDataSource {
  factory IAuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _IAuthRemoteDataSource;

  @POST("/auth/login")
  Future<AuthResponseModel> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST("/auth/register")
  Future<AuthResponseModel> signup(
    @Body() SignUpRequestBody signupRequestBody,
  );

  @DELETE("/auth/logout")
  Future<void> logOut();
}
