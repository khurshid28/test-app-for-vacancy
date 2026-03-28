import 'package:test_app/features/home/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUserProfile();
}
