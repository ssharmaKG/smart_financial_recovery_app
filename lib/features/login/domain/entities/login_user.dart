import 'package:equatable/equatable.dart';

class LoginUser extends Equatable {
  final String id;
  final String email;
  final String? displayName;

  const LoginUser({required this.id, required this.email, this.displayName});

  @override
  List<Object?> get props => [id, email, displayName];
}
