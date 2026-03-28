import 'package:test_app/features/auth/domain/entities/auth_token.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class GoogleSignInUsecase {
  final AuthRepository _repository;

  GoogleSignInUsecase(this._repository);

  Future<AuthToken> call() {
    return _repository.signInWithGoogle();
  }
}
