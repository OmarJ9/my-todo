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

  factory TaskModel.fromjson(Map<String, dynamic> json, String id) {
    return TaskModel(
      id: id,
      title: json['title'],
      note: json['note'],
      date: json['date'],
      starttime: json['starttime'],
      endtime: json['endtime'],
      reminder: json['reminder'],
      colorindex: json['colorindex'],
    );
  }

  Map<String, dynamic> tojson() {
    return {
      'title': title,
      'note': note,
      'date': date,
      'starttime': starttime,
      'endtime': endtime,
      'reminder': reminder,
      'colorindex': colorindex,
    };
  }
}
