part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final int selectedProfileImage;
  final ThemeMode selectedTheme;
  final AppThemeColor selectedThemeColor;

  const ProfileLoaded({
    required this.user,
    required this.selectedProfileImage,
    required this.selectedTheme,
    required this.selectedThemeColor,
  });

  ProfileLoaded copyWith({
    UserModel? user,
    int? selectedProfileImage,
    ThemeMode? selectedTheme,
    AppThemeColor? selectedThemeColor,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      selectedProfileImage: selectedProfileImage ?? this.selectedProfileImage,
      selectedTheme: selectedTheme ?? this.selectedTheme,
      selectedThemeColor: selectedThemeColor ?? this.selectedThemeColor,
    );
  }

  @override
  List<Object?> get props => [
        user,
        selectedProfileImage,
        selectedTheme,
        selectedThemeColor,
      ];
}

class ProfileUpdated extends ProfileState {
  const ProfileUpdated();

  @override
  List<Object?> get props => [];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
