import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/features/auth/data/repository/auth_repository.dart';

part 'authentication_state.dart';

@injectable
class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(this.repo) : super(AuthenticationInitial());

  final IAuthRepository repo;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthenticationLoadingState());
    final result = await repo.login(
      email: email.toLowerCase(),
      password: password,
    );
    result.fold(
      (failure) => emit(AuthenticationErrortate(failure.errorMessage)),
      (success) => emit(AuthenticationSuccessState()),
    );
  }

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    emit(AuthenticationLoadingState());
    final result = await repo.signup(
      username: username,
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthenticationErrortate(failure.errorMessage)),
      (success) => emit(AuthenticationSuccessState()),
    );
  }

  Future<void> signout() async {
    emit(AuthenticationLoadingState());
    try {
      await repo.logOut();
      emit(UnAuthenticationState());
    } catch (e) {
      emit(AuthenticationErrortate(e.toString()));
    }
  }
}
