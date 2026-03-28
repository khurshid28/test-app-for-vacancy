import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app/features/home/domain/entities/business.dart';
import 'package:test_app/features/home/domain/entities/user.dart';
import 'package:test_app/features/home/domain/usecases/get_user_profile_usecase.dart';
import 'package:test_app/features/home/presentation/bloc/user_bloc.dart';
import 'package:test_app/features/home/presentation/bloc/user_event.dart';
import 'package:test_app/features/home/presentation/bloc/user_state.dart';

class MockGetUserProfileUsecase extends Mock
    implements GetUserProfileUsecase {}

void main() {
  late MockGetUserProfileUsecase mockGetUserProfileUsecase;

  final tUser = User(
    id: 'usr_001',
    fullName: 'Test User',
    email: 'test@example.com',
    avatarUrl: 'https://example.com/avatar.jpg',
    phone: '+1234567890',
    registeredAt: DateTime(2023, 1, 1),
    businesses: [
      Business(
        id: 'biz_001',
        name: 'Test Business',
        type: BusinessType.technology,
        revenue: 100000,
        employeesCount: 10,
        isActive: true,
        createdAt: DateTime(2023, 5, 1),
        imageUrl: 'https://example.com/image.jpg',
      ),
    ],
  );

  setUp(() {
    mockGetUserProfileUsecase = MockGetUserProfileUsecase();
  });

  UserBloc buildBloc() =>
      UserBloc(getUserProfileUsecase: mockGetUserProfileUsecase);

  group('UserBloc', () {
    test('initial state is UserInitial', () {
      expect(buildBloc().state, const UserInitial());
    });

    group('LoadUserProfile', () {
      blocTest<UserBloc, UserState>(
        'emits [UserLoading, UserLoaded] on success',
        setUp: () {
          when(() => mockGetUserProfileUsecase())
              .thenAnswer((_) async => tUser);
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const LoadUserProfile()),
        expect: () => [const UserLoading(), UserLoaded(tUser)],
      );

      blocTest<UserBloc, UserState>(
        'emits [UserLoading, UserError] on failure',
        setUp: () {
          when(() => mockGetUserProfileUsecase())
              .thenThrow(Exception('Network error'));
        },
        build: buildBloc,
        act: (bloc) => bloc.add(const LoadUserProfile()),
        expect: () => [
          const UserLoading(),
          isA<UserError>(),
        ],
      );
    });
  });
}
