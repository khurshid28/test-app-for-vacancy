import 'package:test_app/features/home/data/datasources/user_remote_datasource.dart';
import 'package:test_app/features/home/domain/entities/user.dart';
import 'package:test_app/features/home/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl({required this.remoteDatasource});

  @override
  Future<User> getUserProfile() {
    return remoteDatasource.getUserProfile();
  }
}
