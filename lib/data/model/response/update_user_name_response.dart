import 'package:json_annotation/json_annotation.dart';

import '../../../core/base/base_response.dart';

part 'update_user_name_response.g.dart';

@JsonSerializable()
class UpdateUserNameResponse extends BaseResponse {
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'mobile')
  final String? mobile;

  UpdateUserNameResponse({this.name, this.mobile});

  // from json
  factory UpdateUserNameResponse.fromJson(Map<String, dynamic> json) => _$UpdateUserNameResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$UpdateUserNameResponseToJson(this);
}
