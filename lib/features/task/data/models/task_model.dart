import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  @JsonKey(name: "_id")
  final String? id;
  final String? title;
  final String? note;
  final String? date;
  final String? time;
  final int? reminder;
  final int? colorIndex;

  TaskModel({
    this.id,
    this.title,
    this.note,
    this.date,
    this.time,
    this.reminder,
    this.colorIndex,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  @override
  String toString() {
    return 'TaskModel(id: $id, title: $title, note: $note, date: $date, time: $time, reminder: $reminder, colorIndex: $colorIndex)';
  }
}
