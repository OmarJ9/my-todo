import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final String id;
  final String title;
  final String note;
  final String date;
  final String starttime;
  final String endtime;
  final int reminder;
  final int colorindex;

  TaskModel({
    required this.id,
    required this.title,
    required this.note,
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.reminder,
    required this.colorindex,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
