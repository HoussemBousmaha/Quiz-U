import '../../domain/entities/login_model.dart';
import '../model/response/login_response.dart';

const String empty = '';
const int zero = 0;

extension LoginResponseExtension on LoginResponse? {
  LoginModel toDomain() => LoginModel(
        name: this?.name ?? empty,
        token: this?.token ?? empty,
        mobile: this?.mobile ?? empty,
      );
}
