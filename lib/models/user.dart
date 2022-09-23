class User {
  String? id;
  final String? name;
  final String token;
  final String mobile;

  User({
    this.id,
    required this.name,
    required this.token,
    required this.mobile,
  });

  Map<String, String> toJson() {
    return {
      "id": id!,
      "name": name ?? '',
      "token": token,
      "mobile": mobile,
    };
  }
}
