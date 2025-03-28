import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/models/user_model.dart';
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

    // First get the current user data
    final currentUserResult = await _profileRepository.getProfile();

    return currentUserResult.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (currentUser) async {
        // Only update username and avatarIndex
        final updatedUser = currentUser.copyWith(
          username: username,
          avatarIndex: avatarIndex,
        );

        final result = await _profileRepository.updateProfile(updatedUser);
        result.fold(
          (failure) => emit(ProfileError(failure.errorMessage)),
          (_) {
            emit(ProfileUpdated());
            getProfile();
          },
        );
      },
    );
  }
}
