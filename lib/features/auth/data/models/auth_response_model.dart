import 'package:json_annotation/json_annotation.dart';
import '../../../../core/models/user_model.dart';

part 'auth_response_model.g.dart';

@JsonSerializable(createToJson: false)
class AuthResponseModel {
  String? accessToken;
  String? refreshToken;
  UserModel? user;

  AuthResponseModel({
    this.accessToken,
    this.refreshToken,
    this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}
