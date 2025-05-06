import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(createToJson: false)
class AuthResponseModel {
  String accessToken;
  String refreshToken;
  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  @override
  String toString() =>
      'AuthResponseModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}
