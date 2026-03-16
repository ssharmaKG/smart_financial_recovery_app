import 'package:flutter_test/flutter_test.dart';
import 'package:smart_financial_recovery_app/features/login/data/models/login_user_model.dart';
import 'package:smart_financial_recovery_app/features/login/data/repositories/login_repository_impl.dart';

void main() {
  late LoginRepositoryImpl repository;

  setUp(() {
    repository = LoginRepositoryImpl();
  });

  group('LoginRepositoryImpl', () {
    test('returns LoginUser when credentials are valid', () async {
      final result = await repository.signInWithEmailAndPassword(
        email: 'test@email.com',
        password: '123456',
      );

      expect(result, isA<LoginUserModel>());
      expect(result.email, 'test@email.com');
      expect(result.displayName, 'Jane Doe');
    });

    test('throws exception when password is wrong', () async {
      expect(
        () => repository.signInWithEmailAndPassword(
          email: 'test@email.com',
          password: 'wrong',
        ),
        throwsException,
      );
    });
  });
}
