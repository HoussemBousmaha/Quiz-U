import 'package:json_annotation/json_annotation.dart';

import '../../../../../core/base/base_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends BaseResponse {
  @JsonKey(name: 'user_status')
  final String? userStatus;
  @JsonKey(name: 'token')
  final String? token;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'mobile')
  final String? mobile;

  LoginResponse({
    this.userStatus,
    this.token,
    this.name,
    this.mobile,
  });

  // from json
  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
