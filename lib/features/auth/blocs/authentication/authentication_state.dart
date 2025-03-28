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
  final UserModel? user;

  AuthenticationSuccessState({this.user});

  @override
  List<Object?> get props => [user];
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
