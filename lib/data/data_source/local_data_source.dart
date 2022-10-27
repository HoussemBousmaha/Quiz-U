import 'dart:convert';

import 'package:quiz_u_final/data/model/response/top_scores_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/error_handler.dart';

const String tokenKey = 'TOKEN_KEY';
const String storesModelKey = 'STORES_MODEL_KEY';

abstract class LocalDataSource {
  String get token;
  Future<bool> setToken(String token);
  Future<bool> removeToken();

  ScoresResponse get getStoresModel;
  Future<bool> setScoresResponse(ScoresResponse scoresModel);
  Future<bool> removeScoresModel();
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

  @override
  Future<bool> setScoresResponse(ScoresResponse scoresResponse) async {
    final scoresModelAsJson = scoresResponse.toJson();
    final scoresModelString = json.encode(scoresModelAsJson);

    final isStored = await _sharedPreferences.setString(storesModelKey, scoresModelString);

    return isStored;
  }

  @override
  ScoresResponse get getStoresModel {
    final scoresModelString = _sharedPreferences.getString(storesModelKey);

    if (scoresModelString == null) throw ErrorHandler.handle(DataSource.cacheError);

    final scoresModelAsJson = json.decode(scoresModelString);

    return ScoresResponse.fromJson(scoresModelAsJson);
  }

  @override
  Future<bool> removeScoresModel() async => await _sharedPreferences.remove(storesModelKey);
}
