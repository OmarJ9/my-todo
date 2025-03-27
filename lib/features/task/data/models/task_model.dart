import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  @JsonKey(name: "_id")
  final String? id;
  final String? title;
  final String? note;
  final String? date;
  final String? starttime;
  final String? endtime;
  final int? reminder;
  final int? colorindex;

  TaskModel({
    this.id,
    this.title,
    this.note,
    this.date,
    this.starttime,
    this.endtime,
    this.reminder,
    this.colorindex,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
