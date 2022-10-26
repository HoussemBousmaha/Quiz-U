import 'package:dio/dio.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so it's error from response of the API
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.defaultError.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
        return DataSource.connectionTimeOut.getFailure();

      case DioErrorType.sendTimeout:
        return DataSource.sendTimeOut.getFailure();

      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeOut.getFailure();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();
          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();
          case ResponseCode.unauthorised:
            return DataSource.unauthorised.getFailure();
          case ResponseCode.notFound:
            return DataSource.notFound.getFailure();
          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
          default:
            return DataSource.defaultError.getFailure();
        }
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.other:
        return DataSource.defaultError.getFailure();
    }
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectionTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  defaultError,
}

class ResponseCode {
  // API status codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // API failure, rejected request
  static const int forbidden = 403; // API failure, rejected request
  static const int unauthorised = 401; // failure, user is not authaurised
  static const int notFound = 404; // failure, API url is not correct and not found
  static const int internalServerError = 500; // failure, crash happened in server side

  // local status codes
  static const int defaultError = -1;
  static const int connectionTimeOut = -2;
  static const int cancel = -3;
  static const int receiveTimeOut = -4;
  static const int sendTimeOut = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status codes
  static const String success = 'success'; // success with data
  static const String noContent = 'success with no content'; // success with no content
  static const String badRequest = 'bad request, try again later'; // API failure, rejected request
  static const String forbidden = 'forbidden request, try again later'; // API failure, rejected request
  static const String unauthorised = 'user is unothorised, try again later'; // failure, user is not authaurised
  static const String notFound = 'url not found, try again later'; // failure, API url is not correct and not found
  static const String internalServerError =
      'something went wrong, try again later'; // failure, crash happened in server side

  // local status codes
  static const String defaultError = 'something went wrong, try again later';
  static const String connectionTimeOut = 'time out error, try again later';
  static const String cancel = 'request was cancelled, try again later';
  static const String receiveTimeOut = 'time out error, try again later';
  static const String sendTimeOut = 'time out error, try again later';
  static const String cacheError = 'cache error, try again later';
  static const String noInternetConnection = 'please check your internet conection';
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(code: ResponseCode.success, message: ResponseMessage.success);
      case DataSource.noContent:
        return Failure(code: ResponseCode.noContent, message: ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(code: ResponseCode.badRequest, message: ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(code: ResponseCode.forbidden, message: ResponseMessage.forbidden);
      case DataSource.unauthorised:
        return Failure(code: ResponseCode.unauthorised, message: ResponseMessage.unauthorised);
      case DataSource.notFound:
        return Failure(code: ResponseCode.notFound, message: ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(code: ResponseCode.internalServerError, message: ResponseMessage.internalServerError);
      case DataSource.connectionTimeOut:
        return Failure(code: ResponseCode.connectionTimeOut, message: ResponseMessage.connectionTimeOut);
      case DataSource.cancel:
        return Failure(code: ResponseCode.cancel, message: ResponseMessage.cancel);
      case DataSource.receiveTimeOut:
        return Failure(code: ResponseCode.receiveTimeOut, message: ResponseMessage.receiveTimeOut);
      case DataSource.sendTimeOut:
        return Failure(code: ResponseCode.sendTimeOut, message: ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return Failure(code: ResponseCode.cacheError, message: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(code: ResponseCode.noInternetConnection, message: ResponseMessage.noInternetConnection);
      case DataSource.defaultError:
        return Failure(code: ResponseCode.defaultError, message: ResponseMessage.defaultError);
      default:
        return Failure(code: ResponseCode.defaultError, message: ResponseMessage.defaultError);
    }
  }
}

class ApiInternalStatus {
  static const bool success = true;
  static const bool failure = false;
}
