import 'error_handler.dart';

class Failure {
  int code; // 200 or 400
  String message; // error or success

  Failure({required this.code, required this.message});
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(code: ResponseCode.defaultError, message: ResponseMessage.defaultError);
}
