// signup_user_model.dart — model
import '../../domain/entities/signup_user.dart';

class SignupUserModel extends SignupUser {
  const SignupUserModel({
    required super.id,
    required super.fullName,
    required super.email,
  });

  factory SignupUserModel.fromJson(Map<String, dynamic> json) {
    return SignupUserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
  };
}
