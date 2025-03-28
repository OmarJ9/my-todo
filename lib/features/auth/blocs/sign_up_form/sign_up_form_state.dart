part of 'sign_up_form_cubit.dart';

final class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
    this.isPasswordObscure = true,
    this.error,
  });

  final FormzSubmissionStatus status;
  final Email email;
  final Password password;
  final Username username;
  final bool isValid;
  final bool isPasswordObscure;
  final String? error;

  SignUpState copyWith({
    FormzSubmissionStatus? status,
    Email? email,
    Password? password,
    Username? username,
    bool? isValid,
    bool? isPasswordObscure,
    String? error,
  }) {
    return SignUpState(
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      isValid: isValid ?? this.isValid,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        username,
        isValid,
        isPasswordObscure,
        error,
      ];
}
