import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/model/response/login_response.dart';
import '../resources/constants.dart';

part 'app_service_client.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/login")
  Future<LoginResponse> login(
    @Field('OTP') String otp,
    @Field('mobile') String mobile,
  );
}
