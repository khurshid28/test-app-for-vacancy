import 'package:test_app/features/auth/domain/entities/auth_token.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository _repository;

  LoginUsecase(this._repository);

  Future<AuthToken> call({required String email, required String password}) {
    return _repository.login(email: email, password: password);
  }
}
