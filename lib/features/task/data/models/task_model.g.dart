// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      note: json['note'] as String,
      date: json['date'] as String,
      starttime: json['starttime'] as String,
      endtime: json['endtime'] as String,
      reminder: (json['reminder'] as num).toInt(),
      colorindex: (json['colorindex'] as num).toInt(),
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'note': instance.note,
      'date': instance.date,
      'starttime': instance.starttime,
      'endtime': instance.endtime,
      'reminder': instance.reminder,
      'colorindex': instance.colorindex,
    };
