import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/shared/constants/consts_variables.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  int curruntindext = 0;

  Future<void> savepref(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
  }

  void skipindex() {
    curruntindext = onboardinglist.length - 1;

    emit(SkipIndexState());
  }

  void changeindex() {
    curruntindext++;
    emit(ChangeCurrentIndexState());
  }

  void removefromindex() {
    curruntindext--;
    emit(RemoveFromCurrentIndexState());
  }
}
