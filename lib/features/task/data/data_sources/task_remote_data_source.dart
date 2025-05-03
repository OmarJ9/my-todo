import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/task_model.dart';

part 'task_remote_data_source.g.dart';

@RestApi()
abstract class ITaskRemoteDataSource {
  factory ITaskRemoteDataSource(Dio dio, {String baseUrl}) =
      _ITaskRemoteDataSource;

  @GET("/task")
  Future<List<TaskModel>> getTasks(
    @Body() Map<String, dynamic> body,
  );

  @POST("/task")
  Future<TaskModel> addTask(
    @Body() TaskModel task,
  );

  @PUT("/task/{id}")
  Future<void> updateTask(
    @Path('id') String id,
    @Body() TaskModel task,
  );

  @DELETE("/task/{id}")
  Future<void> deleteTask(
    @Path('id') String id,
  );
}
