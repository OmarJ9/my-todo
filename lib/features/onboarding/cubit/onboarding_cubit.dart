import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/services/shared_prefs_service.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  int curruntindext = 0;

  Future<void> savepref() async {
    await getIt.get<CacheService>().setBool(CacheKeys.onBoardingDone, true);
  }

  void skipindex() {
    curruntindext = 2;

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
