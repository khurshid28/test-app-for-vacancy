import 'package:test_app/features/home/domain/entities/user.dart';
import 'package:test_app/features/home/domain/repositories/user_repository.dart';

class GetUserProfileUsecase {
  final UserRepository _repository;

  GetUserProfileUsecase(this._repository);

  Future<User> call() {
    return _repository.getUserProfile();
  }
}
