import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../features/auth/data/models/token_model.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/refresh")
  Future<TokenModel> refreshToken(
    @Header('Authorization') String refreshToken,
  );
}
