import 'dart:math';
import 'package:test_app/features/auth/data/models/token_model.dart';

class AuthRemoteDatasource {
  Future<TokenModel> login({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Mock validation
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    if (password.length < 6) {
      throw Exception('Invalid credentials');
    }

    return TokenModel(
      token: _generateMockToken(),
      expiresAt: DateTime.now().add(const Duration(days: 30)),
    );
  }

  Future<TokenModel> signInWithGoogle() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    return TokenModel(
      token: _generateMockToken(),
      expiresAt: DateTime.now().add(const Duration(days: 30)),
    );
  }

  String _generateMockToken() {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rng = Random.secure();
    return List.generate(64, (_) => chars[rng.nextInt(chars.length)]).join();
  }
}
