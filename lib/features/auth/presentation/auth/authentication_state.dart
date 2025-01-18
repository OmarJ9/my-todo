part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationSuccessState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationErrortate extends AuthenticationState {
  final String error;

  AuthenticationErrortate(this.error);

  @override
  List<Object?> get props => [error];
}

class UnAuthenticationState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileSuccessState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class UpdateProfileErrorState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
