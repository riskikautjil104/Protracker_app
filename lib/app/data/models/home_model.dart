class ProjectHomeCrew {
  String id;
  String name;
  DateTime endDate;
  bool status;
  dynamic progress;
  dynamic productivity;
  dynamic contribution;
  List<Task>? tasks; // List of tasks, nullable

  ProjectHomeCrew({
    required this.id,
    required this.name,
    required this.endDate,
    required this.status,
    required this.progress,
    required this.productivity,
    required this.contribution,
    this.tasks,
  });

  factory ProjectHomeCrew.fromJson(Map<String, dynamic> json) {
    List<Task>? tasksList;
    if (json['tasks'] != null) {
      tasksList =
          List<Task>.from(json['tasks'].map((task) => Task.fromJson(task)));
    }

    return ProjectHomeCrew(
      id: json['id'],
      name: json['name'],
      endDate: DateTime.parse(json['endDate']),
      status: json['status'],
      progress: json['progress'],
      productivity: json['productivity'],
      contribution: json['contribution'],
      tasks: tasksList,
    );
  }
}

class Task {
  String id;
  int week;
  String name;
  bool status;
  DateTime createdAt;
  String crewId;
  String projectId;
  String weekTargetId;
  // Add other properties as needed

  Task({
    required this.id,
    required this.week,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.crewId,
    required this.projectId,
    required this.weekTargetId,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      week: json['week'],
      name: json['name'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      crewId: json['crewId'],
      projectId: json['projectId'],
      weekTargetId: json['weekTargetId'],
    );
  }
}
