class Project1 {
  final String id;
  final String name;
  final DateTime endDate;
  final DateTime startDate;
  final bool status;
  final dynamic progress;
  final List<Task>? tasks;

  Project1({
    required this.id,
    required this.name,
    required this.endDate,
    required this.startDate,
    required this.status,
    dynamic progress,
    this.tasks,
  }) : progress = progress;
 

  factory Project1.fromJson(Map<String, dynamic> json) {
    return Project1(
      id: json['id'] ?? '', 
      name: json['name'] ?? '', 
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'])
          : DateTime.now(),
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : DateTime.now(),
      status: json['status'] ??
          false,
          
      progress: json[
          'progress'],
          
      tasks: json['tasks'] != null
          ? List<Task>.from(json['tasks'].map((task) => Task.fromJson(task)))
          : null,
      
    );
  }
}

class Task {
  final String taskId;
  final String taskName;
  final bool isNew;

  Task({
    required this.taskId,
    required this.taskName,
    required this.isNew,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskId: json['taskId'],
      taskName: json['taskName'],
      isNew: json['isNew'] ?? false, 
    );
  }
}
