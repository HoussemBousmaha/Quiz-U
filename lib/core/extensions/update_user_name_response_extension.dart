import '../../data/model/response/update_user_name_response.dart';
import '../../domain/entities/update_user_name_model.dart';

const String empty = '';

extension UpdateUserNameResponseExtension on UpdateUserNameResponse? {
  UpdateUserNameModel toDomain() => UpdateUserNameModel(
        name: this?.name ?? empty,
        mobile: this?.mobile ?? empty,
      );
}
