class Task {
  int id;
  String text;
  DateTime startTime;
  DateTime endTime;

  Task(this.id, this.text, this.startTime, this.endTime);

  late Duration diffTime = endTime.difference(startTime);

  String toJson() {
    return '''{
      "id": "$id",
      "text": "$text",
      "startTime": "$startTime",
      "endTime": "$endTime"
    }''';
  }

  factory Task.fromJson(dynamic json) {
    return Task(int.parse(json['id']), json['text'],
    DateTime.parse(json['startTime']), DateTime.parse(json['endTime']));
  }
}
