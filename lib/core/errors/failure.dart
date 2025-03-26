import 'package:equatable/equatable.dart';

abstract class Failure {
  final dynamic errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure with EquatableMixin {
  ServerFailure({required super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class CacheFailure extends Failure with EquatableMixin {
  CacheFailure({required super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class NetworkFailure extends Failure with EquatableMixin {
  NetworkFailure({required super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class TokenFailure extends Failure with EquatableMixin {
  TokenFailure({required super.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
