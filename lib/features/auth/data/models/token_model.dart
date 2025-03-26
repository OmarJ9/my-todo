import 'package:json_annotation/json_annotation.dart';

part 'token_model.g.dart';

@JsonSerializable(createToJson: false)
class TokenModel {
  String accessToken;
  String refreshToken;
  bool? created;

  TokenModel({
    required this.accessToken,
    required this.refreshToken,
    this.created,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}
