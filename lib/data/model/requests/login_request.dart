// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/base/base_request.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends BaseRequest {
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
