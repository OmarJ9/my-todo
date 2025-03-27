// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponseModel _$TaskResponseModelFromJson(Map<String, dynamic> json) =>
    TaskResponseModel(
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskResponseModelToJson(TaskResponseModel instance) =>
    <String, dynamic>{
      'tasks': instance.tasks,
    };
