import '../../data/model/response/login_response.dart';
import '../../domain/entities/login_model.dart';

const String empty = '';

extension LoginResponseExtension on LoginResponse? {
  LoginModel toDomain() => LoginModel(
        name: this?.name ?? empty,
        token: this?.token ?? empty,
        mobile: this?.mobile ?? empty,
        userStatus: this?.userStatus ?? empty,
      );
}
