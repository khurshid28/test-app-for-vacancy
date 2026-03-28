import 'package:test_app/core/storage/secure_storage.dart';
import 'package:test_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:test_app/features/auth/domain/entities/auth_token.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;
  final SecureStorage secureStorage;

  AuthRepositoryImpl({
    required this.remoteDatasource,
    required this.secureStorage,
  });

  @override
  Future<AuthToken> login({
    required String email,
    required String password,
  }) async {
    final token = await remoteDatasource.login(
      email: email,
      password: password,
    );
    await secureStorage.saveToken(token.token);
    return token;
  }

  @override
  Future<AuthToken> signInWithGoogle() async {
    final token = await remoteDatasource.signInWithGoogle();
    await secureStorage.saveToken(token.token);
    return token;
  }

  @override
  Future<void> logout() async {
    await secureStorage.deleteToken();
  }

  @override
  Future<bool> isAuthenticated() async {
    return secureStorage.hasToken();
  }
}
