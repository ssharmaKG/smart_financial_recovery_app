import '../../domain/entities/login_user.dart';

class LoginUserModel extends LoginUser {
  const LoginUserModel({
    required super.id,
    required super.email,
    super.displayName,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'displayName': displayName,
  };
}
