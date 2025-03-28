import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/user_model.dart';
import '../../data/repository/profile_repository.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  final IProfileRepository _profileRepository;

  int profileimagesindex = 0;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    await Future.delayed(const Duration(seconds: 2));
    final result = await _profileRepository.getProfile();
    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (user) {
        if (user.avatarIndex != null) {
          profileimagesindex = user.avatarIndex!;
        }
        emit(ProfileLoaded(user));
      },
    );
  }

  Future<void> updateProfile({
    required String username,
    required int avatarIndex,
  }) async {
    emit(ProfileLoading());

    final user = UserModel(
      id: "1",
      username: username,
      avatarIndex: avatarIndex,
      email: "test@test.com",
    );

    final result = await _profileRepository.updateProfile(user);
    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (_) {
        emit(ProfileUpdated());
        getProfile();
      },
    );
  }
}
