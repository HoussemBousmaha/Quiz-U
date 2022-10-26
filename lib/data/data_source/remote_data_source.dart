import 'package:quiz_u_final/core/network/app_service_client.dart';

import '../model/requests/login_request.dart';

import '../model/response/login_response.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImplementer(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.otp,
      loginRequest.mobile,
    );
  }
}
