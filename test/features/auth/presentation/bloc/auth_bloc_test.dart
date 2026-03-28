import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app/core/storage/secure_storage.dart';
import 'package:test_app/features/auth/domain/entities/auth_token.dart';
import 'package:test_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_state.dart';

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockGoogleSignInUsecase extends Mock implements GoogleSignInUsecase {}

class MockLogoutUsecase extends Mock implements LogoutUsecase {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  late MockLoginUsecase mockLoginUsecase;
  late MockGoogleSignInUsecase mockGoogleSignInUsecase;
  late MockLogoutUsecase mockLogoutUsecase;
  late MockSecureStorage mockSecureStorage;

  final tToken = AuthToken(
    token: 'test_token_123',
    expiresAt: DateTime.now().add(const Duration(days: 30)),
  );

  setUp(() {
    mockLoginUsecase = MockLoginUsecase();
    mockGoogleSignInUsecase = MockGoogleSignInUsecase();
    mockLogoutUsecase = MockLogoutUsecase();
    mockSecureStorage = MockSecureStorage();
  });

  AuthBloc buildBloc() => AuthBloc(
        loginUsecase: mockLoginUsecase,
        googleSignInUsecase: mockGoogleSignInUsecase,
        logoutUsecase: mockLogoutUsecase,
        secureStorage: mockSecureStorage,
      );

  group('AuthBloc', () {
    test('initial state is AuthInitial', () {
      expect(buildBloc().state, const AuthInitial());
    });

    group('CheckAuthStatus', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthAuthenticated] when token exists',
        setUp: () {
          when(() => mockSecureStorage.hasToken())
              .thenAnswer((_) async => true);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const CheckAuthStatus()),
        expect: () => [const AuthAuthenticated()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthUnauthenticated] when no token',
        setUp: () {
          when(() => mockSecureStorage.hasToken())
              .thenAnswer((_) async => false);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const CheckAuthStatus()),
        expect: () => [const AuthUnauthenticated()],
      );
    });

    group('LoginRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] on success',
        setUp: () {
          when(() => mockLoginUsecase(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenAnswer((_) async => tToken);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const LoginRequested(
          email: 'test@example.com',
          password: 'password123',
        )),
        expect: () => [const AuthLoading(), const AuthAuthenticated()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] on failure',
        setUp: () {
          when(() => mockLoginUsecase(
                email: any(named: 'email'),
                password: any(named: 'password'),
              )).thenThrow(Exception('Invalid credentials'));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const LoginRequested(
          email: 'test@example.com',
          password: 'wrong',
        )),
        expect: () => [
          const AuthLoading(),
          isA<AuthError>(),
        ],
      );
    });

    group('GoogleSignInRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] on success',
        setUp: () {
          when(() => mockGoogleSignInUsecase())
              .thenAnswer((_) async => tToken);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const GoogleSignInRequested()),
        expect: () => [const AuthLoading(), const AuthAuthenticated()],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [AuthLoading, AuthError] on failure',
        setUp: () {
          when(() => mockGoogleSignInUsecase())
              .thenThrow(Exception('Google Sign-In failed'));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const GoogleSignInRequested()),
        expect: () => [
          const AuthLoading(),
          isA<AuthError>(),
        ],
      );
    });

    group('LogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'emits [AuthUnauthenticated] on logout',
        setUp: () {
          when(() => mockLogoutUsecase()).thenAnswer((_) async {});
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const LogoutRequested()),
        expect: () => [const AuthUnauthenticated()],
      );
    });
  });
}
