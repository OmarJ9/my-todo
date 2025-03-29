part of 'task_cubit.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<TaskModel> tasks;

  const TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskAdded extends TaskState {
  const TaskAdded();

  @override
  List<Object?> get props => [];
}

class TaskUpdated extends TaskState {
  const TaskUpdated();

  @override
  List<Object?> get props => [];
}

class TaskDeleted extends TaskState {
  final String id;

  const TaskDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}
