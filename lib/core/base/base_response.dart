import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: 'success')
  bool? success;
  @JsonKey(name: 'message')
  String? message;
}
