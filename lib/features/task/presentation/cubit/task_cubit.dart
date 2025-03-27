import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/task_model.dart';
import '../../data/repository/task_repository.dart';

part 'task_state.dart';

@injectable
class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this._taskRepository) : super(TaskInitial());

  final ITaskRepository _taskRepository;

  Future<void> getTasks(String date) async {
    emit(TaskLoading());
    final result = await _taskRepository.getTasks(date);
    result.fold(
      (failure) => emit(TaskError(failure.errorMessage)),
      (tasks) => emit(TaskLoaded(tasks)),
    );
  }

  Future<void> addTask(TaskModel task) async {
    emit(TaskLoading());
    final result = await _taskRepository.addTask(task);
    result.fold(
      (failure) => emit(TaskError(failure.errorMessage)),
      (_) => emit(const TaskAdded()),
    );
  }

  Future<void> updateTask(TaskModel task) async {
    emit(TaskLoading());
    final result = await _taskRepository.updateTask(task);
    result.fold(
      (failure) => emit(TaskError(failure.errorMessage)),
      (updatedTask) => emit(TaskUpdated(updatedTask)),
    );
  }

  Future<void> deleteTask(String id) async {
    final result = await _taskRepository.deleteTask(id);
    result.fold(
      (failure) => emit(TaskError(failure.errorMessage)),
      (_) => emit(TaskDeleted(id)),
    );
  }
}
