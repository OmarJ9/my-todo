import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/login_request_model.dart';
import '../models/sign_up_request_model.dart';
import '../models/token_model.dart';

part 'auth_remote_data_source.g.dart';

@RestApi()
abstract class IAuthRemoteDataSource {
  factory IAuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _IAuthRemoteDataSource;

  @POST("/auth/login")
  Future<TokenModel> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST("/auth/register")
  Future<TokenModel> signup(
    @Body() SignUpRequestBody signupRequestBody,
  );

  @DELETE("/auth/logout")
  Future<void> logOut();
}
