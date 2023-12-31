class Tasks {
  final String id;
  final int week;
  final String name;
  final bool status;
  final DateTime createdAt;
  final String crewId;
  final String projectId;
  final String weekTargetId;

  Tasks({
    required this.id,
    required this.week,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.crewId,
    required this.projectId,
    required this.weekTargetId,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      id: json['id'] ?? '',
      week: json['week'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      crewId: json['crewId'] ?? '',
      projectId: json['projectId'] ?? '',
      weekTargetId: json['weekTargetId'] ?? '',
    );
  }
}
