import 'package:json_annotation/json_annotation.dart';

part 'base_request.g.dart';

@JsonSerializable()
class BaseRequest {
  @JsonKey(name: 'OTP')
  String otp = '0000';
}
