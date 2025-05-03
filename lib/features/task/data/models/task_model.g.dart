// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      note: json['note'] as String?,
      date: json['date'] as String?,
      time: json['time'] as String?,
      reminder: (json['reminder'] as num?)?.toInt(),
      colorIndex: (json['colorIndex'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'date': instance.date,
      'time': instance.time,
      'reminder': instance.reminder,
      'colorIndex': instance.colorIndex,
    };
