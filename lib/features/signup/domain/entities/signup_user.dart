import 'package:equatable/equatable.dart';

class SignupUser extends Equatable {
  final String id;
  final String fullName;
  final String email;

  const SignupUser({
    required this.id,
    required this.fullName,
    required this.email,
  });

  @override
  List<Object?> get props => [id, fullName, email];
}
