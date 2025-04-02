import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(createToJson: false)
class AuthResponseModel {
  String accessToken;

  AuthResponseModel({
    required this.accessToken,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  @override
  String toString() => 'AuthResponseModel(accessToken: $accessToken)';
}
