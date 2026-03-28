import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/features/auth/domain/entities/auth_token.dart';

void main() {
  group('AuthToken', () {
    test('isExpired returns false for future date', () {
      final token = AuthToken(
        token: 'test_token',
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      );
      expect(token.isExpired, false);
    });

    test('isExpired returns true for past date', () {
      final token = AuthToken(
        token: 'test_token',
        expiresAt: DateTime.now().subtract(const Duration(days: 1)),
      );
      expect(token.isExpired, true);
    });

    test('supports equality', () {
      final expiresAt = DateTime(2025, 12, 31);
      final token1 = AuthToken(token: 'abc', expiresAt: expiresAt);
      final token2 = AuthToken(token: 'abc', expiresAt: expiresAt);
      expect(token1, token2);
    });
  });
}
