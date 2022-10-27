import 'package:json_annotation/json_annotation.dart';

import '../../../core/base/base_request.dart';

part 'update_user_name_request.g.dart';

@JsonSerializable()
class UpdateUserNameRequest extends BaseRequest {
  @JsonKey(name: 'name')
  final String name;

  UpdateUserNameRequest({required this.name});

  // from json
  factory UpdateUserNameRequest.fromJson(Map<String, dynamic> json) => _$UpdateUserNameRequestFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$UpdateUserNameRequestToJson(this);
}
