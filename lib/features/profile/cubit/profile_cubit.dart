import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../core/models/user_model.dart';
import '../../../core/theme/app_thems.dart';
import '../../../core/theme/theme_cubit.dart';
import '../data/repository/profile_repository.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepository) : super(ProfileInitial());

  final IProfileRepository _profileRepository;

  int _selectedProfileImage = 0;
  ThemeMode _selectedTheme = ThemeMode.system;
  AppThemeColor _selectedThemeColor = AppThemeColor.purple;

  int get selectedProfileImage => _selectedProfileImage;
  ThemeMode get selectedTheme => _selectedTheme;
  AppThemeColor get selectedThemeColor => _selectedThemeColor;

  void initializeTheme(ThemeCubit themeCubit) {
    final currentTheme = themeCubit.state;
    for (var entry in AppTheme.themes.entries) {
      if (entry.value == currentTheme) {
        _selectedThemeColor = entry.key;
        break;
      }
    }
  }

  void changeTheme(ThemeMode theme) {
    _selectedTheme = theme;
    if (state is ProfileLoaded) {
      emit((state as ProfileLoaded).copyWith(selectedTheme: theme));
    }
  }

  void changeThemeColor(AppThemeColor themeColor, ThemeCubit themeCubit) {
    _selectedThemeColor = themeColor;
    themeCubit.changeTheme(themeColor);
    if (state is ProfileLoaded) {
      emit((state as ProfileLoaded).copyWith(selectedThemeColor: themeColor));
    }
  }

  void selectProfileImage(int index) {
    _selectedProfileImage = index;
    if (state is ProfileLoaded) {
      emit((state as ProfileLoaded).copyWith(selectedProfileImage: index));
    }
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await _profileRepository.getProfile();
    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (user) {
        _selectedProfileImage = user.avatarIndex ?? 0;

        emit(
          ProfileLoaded(
            user: user,
            selectedProfileImage: _selectedProfileImage,
            selectedTheme: _selectedTheme,
            selectedThemeColor: _selectedThemeColor,
          ),
        );
      },
    );
  }

  Future<void> updateProfile() async {
    emit(ProfileLoading());

    final user = UserModel(
      avatarIndex: _selectedProfileImage,
    );

    final result = await _profileRepository.updateProfile(user);

    result.fold(
      (failure) => emit(ProfileError(failure.errorMessage)),
      (user) {
        emit(ProfileUpdated());
        emit(
          ProfileLoaded(
            user: user,
            selectedProfileImage: _selectedProfileImage,
            selectedTheme: _selectedTheme,
            selectedThemeColor: _selectedThemeColor,
          ),
        );
      },
    );
  }
}
