import 'package:test_app/features/auth/domain/entities/auth_token.dart';

abstract class AuthRepository {
  Future<AuthToken> login({required String email, required String password});
  Future<AuthToken> signInWithGoogle();
  Future<void> logout();
  Future<bool> isAuthenticated();
}
