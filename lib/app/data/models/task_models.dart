class TaskModel {
  final int code;
  final TaskData? data;

  TaskModel({
    required this.code,
    required this.data,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      code: json['code'] ?? 0,
      data: json['data'] != null ? TaskData.fromJson(json['data']) : null,
    );
  }
}

class TaskData {
  final String id;
  final String name;
  final bool status;
  final String crewName;
  final String createdAt;
  final String startDate;
  final String endDate;
  final int week;
  final String labels;

  TaskData({
    required this.id,
    required this.name,
    required this.status,
    required this.crewName,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.week,
    required this.labels,
  });

  factory TaskData.fromJson(Map<String, dynamic> json) {
    return TaskData(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      status: json['status'] ?? false,
      crewName: json['crewName'] ?? '',
      createdAt: json['createdAt'] ?? '',
      startDate: json['startDate'] ?? '',
      endDate: json['endDate'] ?? '',
      week: json['week'] ?? 0,
      labels: json['labels'] ?? '',
    );
  }
}


// khusus untuk PM
// project_model.dart

