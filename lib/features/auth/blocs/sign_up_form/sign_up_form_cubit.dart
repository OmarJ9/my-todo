import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../core/value_objects/email.dart';
import '../../../../core/value_objects/password.dart';
import '../../../../core/value_objects/username.dart';
part 'sign_up_form_state.dart';

class SignUpFormCubit extends Cubit<SignUpState> {
  SignUpFormCubit() : super(const SignUpState());

  void changePasswordObscurity() {
    emit(state.copyWith(
      isPasswordObscure: !state.isPasswordObscure,
      error: null,
    ));
  }

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(state.copyWith(
      username: username,
      isValid: Formz.validate([
        username,
        state.email,
        state.password,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([
        email,
        state.password,
        state.username,
      ]),
      error: null,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([
        state.email,
        password,
        state.username,
      ]),
      error: null,
    ));
  }

  Future<void> signup() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
  }
}
