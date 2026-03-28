import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository _repository;

  LogoutUsecase(this._repository);

  Future<void> call() {
    return _repository.logout();
  }
}
