import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/features/home/domain/usecases/get_user_profile_usecase.dart';
import 'package:test_app/features/home/presentation/bloc/user_event.dart';
import 'package:test_app/features/home/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserProfileUsecase getUserProfileUsecase;

  UserBloc({required this.getUserProfileUsecase})
      : super(const UserInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    try {
      final user = await getUserProfileUsecase();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
