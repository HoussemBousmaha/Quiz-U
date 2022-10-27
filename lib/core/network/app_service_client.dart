import 'package:dio/dio.dart';
import 'package:quiz_u_final/data/model/response/score_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/model/response/login_response.dart';
import '../../data/model/response/top_scores_response.dart';
import '../../data/model/response/update_user_name_response.dart';
import '../resources/constants.dart';

part 'app_service_client.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/login")
  Future<LoginResponse> login(@Field('OTP') String otp, @Field('mobile') String mobile);

  @POST("/name")
  Future<UpdateUserNameResponse> updateUserName(
    @Header('Authorization') String token,
    @Field('name') String name,
  );

  @GET("/TopScores")
  Future<ScoresResponse> getTopScores(
    @Header('Authorization') String token,
  );
}
