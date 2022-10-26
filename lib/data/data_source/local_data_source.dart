import 'package:shared_preferences/shared_preferences.dart';

const String tokenKey = 'TOKEN_KEY';

abstract class LocalDataSource {
  String get token;
  Future<bool> setToken(String token);
  Future<bool> removeToken();
}

class LocalDataSourceImplementer implements LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImplementer(this._sharedPreferences);

  @override
  Future<bool> setToken(String token) async => await _sharedPreferences.setString(tokenKey, token);

  @override
  String get token => _sharedPreferences.getString(tokenKey) ?? '';

  @override
  Future<bool> removeToken() async => await _sharedPreferences.remove(tokenKey);
}
