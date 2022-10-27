import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'OTP')
  final String otp;
  @JsonKey(name: 'mobile')
  final String mobile;

  LoginRequest({required this.otp, required this.mobile});

  // from json
  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
