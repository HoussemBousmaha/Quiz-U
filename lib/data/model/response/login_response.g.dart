// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      userStatus: json['user_status'] as String?,
      token: json['token'] as String?,
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?;

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'user_status': instance.userStatus,
      'token': instance.token,
      'name': instance.name,
      'mobile': instance.mobile,
    };
