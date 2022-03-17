import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:todo_app/data/repositories/firebase_auth.dart';
import 'package:todo_app/presentation/widgets/mysnackbar.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  FirebaseAuthRepo firebaseauthrepo = FirebaseAuthRepo();

  login({required String email, required String password}) {
    emit(AuthenticationLoadingState());
    firebaseauthrepo.login(email: email, password: password).then((value) {
      final user = FirebaseAuth.instance.currentUser;
      user!.displayName == '' ? user.updateDisplayName('User') : null;
      emit(AuthenticationSuccessState());
    }).catchError((e) {
      emit(AuthenticationErrortate(e.toString()));
      emit(UnAuthenticationState());
    });
  }

  googleSignIn() {
    emit(AuthenticationLoadingState());
    firebaseauthrepo.googleSignIn().then((value) {
      emit(AuthenticationSuccessState());
    }).catchError((e) {
      emit(AuthenticationErrortate(e.toString()));
      emit(UnAuthenticationState());
    });
  }

  register(
      {required String fullname,
      required String email,
      required String password}) {
    emit(AuthenticationLoadingState());
    firebaseauthrepo
        .register(fullname: fullname, email: email, password: password)
        .then((value) {
      emit(AuthenticationSuccessState());

      final user = FirebaseAuth.instance.currentUser;
      user!.updateDisplayName(fullname);
    }).catchError((e) {
      emit(AuthenticationErrortate(e.toString()));
      emit(UnAuthenticationState());
    });
  }

  signinanonym() {
    emit(AuthenticationLoadingState());
    firebaseauthrepo.signinanonym().then((value) {
      emit(AuthenticationSuccessState());
    });
  }

  signout() async {
    await firebaseauthrepo.logout();
    emit(UnAuthenticationState());
  }

  var count = 0;

  void updateUserInfo(String txt, BuildContext context) {
    count >= 2 ? count = 0 : null;
    emit(UpdateProfileLoadingState());
    var user = FirebaseAuth.instance.currentUser;
    user!.updateDisplayName(txt).then((value) {
      count++;
      Future.delayed(const Duration(seconds: 2));
      emit(UpdateProfileSuccessState());

      // You need to click twice to update it
      count == 2
          ? Navigator.pop(context)
          : MySnackBar.error(
              message: 'Please Click Another Time !!',
              color: Colors.indigo,
              context: context);
    }).catchError((e) {
      emit(UpdateProfileErrorState());
      MySnackBar.error(
          message: 'Please Check Your Internet Connection!!',
          color: Colors.red,
          context: context);
    });
  }
}
