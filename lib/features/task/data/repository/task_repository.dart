import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:todo_app/core/errors/failure.dart';
import 'package:todo_app/core/network/dio_exception.dart';
import '../data_sources/task_remote_data_source.dart';
import '../models/task_model.dart';

abstract class ITaskRepository {
  Future<Either<Failure, List<TaskModel>>> getTasks(String date);
  Future<Either<Failure, bool>> addTask(TaskModel task);
  Future<Either<Failure, bool>> updateTask(TaskModel task);
  Future<Either<Failure, void>> deleteTask(String id);
}

@LazySingleton(as: ITaskRepository)
class TaskRepository implements ITaskRepository {
  final ITaskRemoteDataSource _taskRemoteDataSource;

  TaskRepository(this._taskRemoteDataSource);

  @override
  Future<Either<Failure, List<TaskModel>>> getTasks(String date) async {
    try {
      final response = await _taskRemoteDataSource.getTasks(
        {
          'date': date,
        },
      );
      return right(response);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debugPrint('DioException: $errorMessage');
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, bool>> addTask(TaskModel task) async {
    try {
      debugPrint('Adding task: $task');
      await _taskRemoteDataSource.addTask(task);
      return right(true);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      debugPrint('DioException: $errorMessage');

      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, bool>> updateTask(TaskModel task) async {
    try {
      await _taskRemoteDataSource.updateTask(
        task.id ?? '',
        task,
      );
      return right(true);
    } on DioException catch (e) {
      debugPrint('DioException: $e');
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      await _taskRemoteDataSource.deleteTask(id);
      return right(null);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e);
      return left(ServerFailure(errorMessage: errorMessage.message));
    } catch (e) {
      return left(ServerFailure(errorMessage: "Something went wrong"));
    }
  }
}
