import 'package:json_annotation/json_annotation.dart';
import 'task_model.dart';

part 'task_response_model.g.dart';

@JsonSerializable()
class TaskResponseModel {
  final List<TaskModel> tasks;

  TaskResponseModel({
    required this.tasks,
  });

  factory TaskResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskResponseModelToJson(this);
}
