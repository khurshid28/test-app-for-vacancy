import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_app/core/storage/secure_storage.dart';
import 'package:test_app/core/network/dio_client.dart';
import 'package:test_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/google_sign_in_usecase.dart';
import 'package:test_app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/features/home/data/datasources/user_remote_datasource.dart';
import 'package:test_app/features/home/data/repositories/user_repository_impl.dart';
import 'package:test_app/features/home/domain/repositories/user_repository.dart';
import 'package:test_app/features/home/domain/usecases/get_user_profile_usecase.dart';
import 'package:test_app/features/home/presentation/bloc/user_bloc.dart';
import 'package:test_app/app/theme/theme_cubit.dart';
import 'package:test_app/core/l10n/locale_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Core
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());
  sl.registerLazySingleton<DioClient>(
    () => DioClient(secureStorage: sl<SecureStorage>()),
  );

  // Cubits (app-level)
  sl.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(sl<SharedPreferences>()),
  );
  sl.registerLazySingleton<LocaleCubit>(
    () => LocaleCubit(sl<SharedPreferences>()),
  );

  // Auth
  sl.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: sl<AuthRemoteDatasource>(),
      secureStorage: sl<SecureStorage>(),
    ),
  );
  sl.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GoogleSignInUsecase>(
    () => GoogleSignInUsecase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(sl<AuthRepository>()),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUsecase: sl<LoginUsecase>(),
      googleSignInUsecase: sl<GoogleSignInUsecase>(),
      logoutUsecase: sl<LogoutUsecase>(),
      secureStorage: sl<SecureStorage>(),
    ),
  );

  // Home / User
  sl.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasource(),
  );
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDatasource: sl<UserRemoteDatasource>()),
  );
  sl.registerLazySingleton<GetUserProfileUsecase>(
    () => GetUserProfileUsecase(sl<UserRepository>()),
  );
  sl.registerFactory<UserBloc>(
    () => UserBloc(getUserProfileUsecase: sl<GetUserProfileUsecase>()),
  );
}
