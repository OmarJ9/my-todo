import 'package:formz/formz.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/value_objects/email.dart';
import '../../../../core/value_objects/password.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginState> {
  LoginFormCubit() : super(const LoginState());

  void changeObscurity() {
    emit(state.copyWith(
      isObscure: !state.isObscure,
      error: null,
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      isValid: Formz.validate([email, state.password]),
      error: null,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValid: Formz.validate([password, state.email]),
      error: null,
    ));
  }

  Future<void> login() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
  }
}
