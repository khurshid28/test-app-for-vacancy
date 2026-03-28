import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app/core/storage/secure_storage.dart';
import 'package:test_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:test_app/features/auth/data/models/token_model.dart';
import 'package:test_app/features/auth/data/repositories/auth_repository_impl.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late MockAuthRemoteDatasource mockDatasource;
  late MockSecureStorage mockStorage;
  late AuthRepositoryImpl repository;

  final tToken = TokenModel(
    token: 'mock_token',
    expiresAt: DateTime.now().add(const Duration(days: 30)),
  );

  setUp(() {
    mockDatasource = MockAuthRemoteDatasource();
    mockStorage = MockSecureStorage();
    repository = AuthRepositoryImpl(
      remoteDatasource: mockDatasource,
      secureStorage: mockStorage,
    );
  });

  group('AuthRepositoryImpl', () {
    group('login', () {
      test('calls datasource and saves token on success', () async {
        when(() => mockDatasource.login(
              email: any(named: 'email'),
              password: any(named: 'password'),
            )).thenAnswer((_) async => tToken);
        when(() => mockStorage.saveToken(any()))
            .thenAnswer((_) async {});

        final result = await repository.login(
          email: 'test@example.com',
          password: 'pass123',
        );

        expect(result.token, tToken.token);
        verify(() => mockStorage.saveToken(tToken.token)).called(1);
      });
    });

    group('signInWithGoogle', () {
      test('calls datasource and saves token on success', () async {
        when(() => mockDatasource.signInWithGoogle())
            .thenAnswer((_) async => tToken);
        when(() => mockStorage.saveToken(any()))
            .thenAnswer((_) async {});

        final result = await repository.signInWithGoogle();

        expect(result.token, tToken.token);
        verify(() => mockStorage.saveToken(tToken.token)).called(1);
      });
    });

    group('logout', () {
      test('deletes token from storage', () async {
        when(() => mockStorage.deleteToken()).thenAnswer((_) async {});

        await repository.logout();

        verify(() => mockStorage.deleteToken()).called(1);
      });
    });

    group('isAuthenticated', () {
      test('returns true when token exists', () async {
        when(() => mockStorage.hasToken()).thenAnswer((_) async => true);

        final result = await repository.isAuthenticated();

        expect(result, true);
      });

      test('returns false when no token', () async {
        when(() => mockStorage.hasToken()).thenAnswer((_) async => false);

        final result = await repository.isAuthenticated();

        expect(result, false);
      });
    });
  });
}
