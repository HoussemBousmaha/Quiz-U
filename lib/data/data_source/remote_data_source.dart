import '../../core/network/app_service_client.dart';
import '../model/requests/login_request.dart';
import '../model/requests/update_user_name_request.dart';
import '../model/response/login_response.dart';
import '../model/response/update_user_name_response.dart';
import 'local_data_source.dart';

abstract class RemoteDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<UpdateUserNameResponse> updateUserName(UpdateUserNameRequest updateUserNameRequest);
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  final LocalDataSource _localDataSource;

  RemoteDataSourceImplementer(this._appServiceClient, this._localDataSource);

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.otp,
      loginRequest.mobile,
    );
  }

  @override
  Future<UpdateUserNameResponse> updateUserName(UpdateUserNameRequest updateUserNameRequest) async {
    return _appServiceClient.updateUserName(
      _localDataSource.token,
      updateUserNameRequest.name,
    );
  }
}
