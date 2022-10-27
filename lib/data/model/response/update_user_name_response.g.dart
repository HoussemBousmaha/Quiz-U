// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_name_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserNameResponse _$UpdateUserNameResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserNameResponse(
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$UpdateUserNameResponseToJson(
        UpdateUserNameResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'name': instance.name,
      'mobile': instance.mobile,
    };
