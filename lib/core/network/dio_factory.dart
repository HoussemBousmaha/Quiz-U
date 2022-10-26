import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../data/data_source/local_data_source.dart';
import '../resources/constants.dart';

const String contentType = 'content-type';
const String authorization = 'authorization';

const String applicationJson = 'application/json';
const String accept = 'accept';

class DioFactory {
  final LocalDataSource _localDataSource;

  DioFactory(this._localDataSource);

  Future<Dio> getDio() async {
    // dio instance
    Dio dio = Dio();

    // time out
    const int timeOut = 60 * 1000; // one minute

    final token = _localDataSource.token;

    // headers
    final Map<String, String> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: token,
    };

    // update dio options
    dio.options = BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      headers: headers,
    );

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          maxWidth: 400,
        ),
      );
    }

    return dio;
  }
}
