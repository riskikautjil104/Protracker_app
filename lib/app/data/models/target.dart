class Target {
  String id;
  int week;
  dynamic labels;
  DateTime startDate;
  DateTime endDate;
  int taskCompleted;
  int target;

  Target({
    required this.id,
    required this.week,
    required this.labels,
    required this.startDate,
    required this.endDate,
    required this.taskCompleted,
    required this.target,
  });

  factory Target.fromJson(Map<String, dynamic> json) => Target(
        id: json["id"],
        week: json["week"],
        labels: json["labels"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        taskCompleted: json["taskCompleted"],
        target: json["target"],
      );
}
