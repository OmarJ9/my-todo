import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/task_model.dart';
import '../models/task_response_model.dart';

part 'task_remote_data_source.g.dart';

@RestApi()
abstract class ITaskRemoteDataSource {
  factory ITaskRemoteDataSource(Dio dio, {String baseUrl}) =
      _ITaskRemoteDataSource;

  @GET("/tasks")
  Future<TaskResponseModel> getTasks(
    @Body() Map<String, dynamic> body,
  );

  @POST("/tasks")
  Future<TaskModel> addTask(
    @Body() TaskModel task,
  );

  @PUT("/tasks/{id}")
  Future<TaskModel> updateTask(
    @Path('id') String id,
    @Body() TaskModel task,
  );

  @DELETE("/tasks/{id}")
  Future<void> deleteTask(
    @Path('id') String id,
  );
}
