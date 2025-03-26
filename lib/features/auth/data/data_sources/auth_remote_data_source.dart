import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/login_request_model.dart';
import '../models/sign_up_request_model.dart';
import '../models/token_model.dart';

part 'auth_remote_data_source.g.dart';

class AuthApiConstants {
  static const String login = 'signin';
  static const String signup = 'signup';
  static const String logout = 'logout';
}

@RestApi()
abstract class IAuthRemoteDataSource {
  factory IAuthRemoteDataSource(Dio dio, {String baseUrl}) =
      _IAuthRemoteDataSource;

  @POST(AuthApiConstants.login)
  Future<TokenModel> login(
    @Body() LoginRequestBody loginRequestBody,
  );

  @POST(AuthApiConstants.signup)
  Future<TokenModel> signup(
    @Body() SignUpRequestBody signupRequestBody,
  );

  @DELETE(AuthApiConstants.logout)
  Future<void> logOut();
}
