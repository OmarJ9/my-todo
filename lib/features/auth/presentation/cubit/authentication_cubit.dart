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
  }) async {}

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {}

  Future<void> signout() async {}
}
