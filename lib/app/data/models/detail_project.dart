class DetailProject {
  final int code;
  final DetailProjectData data;

  DetailProject({required this.code, required this.data});

  factory DetailProject.fromJson(Map<String, dynamic> json) {
    return DetailProject(
      code: json['code'] ?? 0,
      data: DetailProjectData.fromJson(json['data'] ?? {}),
    );
  }
}

class DetailProjectData {
  final String id;
  final String name;
  final String description;
  final String pmName;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final bool status;

  DetailProjectData({
    required this.id,
    required this.name,
    required this.description,
    required this.pmName,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory DetailProjectData.fromJson(Map<String, dynamic> json) {
    return DetailProjectData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pmName: json['pmName'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      startDate: DateTime.parse(json['startDate'] ?? ''),
      endDate: DateTime.parse(json['endDate'] ?? ''),
      status: json['status'] ?? false,
    );
  }
}
