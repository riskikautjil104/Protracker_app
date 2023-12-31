import 'dart:convert';

class Project {
  int code;
  List<Projects> data;

  Project({
    required this.code,
    required this.data,
  });

  factory Project.fromRawJson(String str) => Project.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        code: json["code"],
        data:
            List<Projects>.from(json["data"].map((x) => Projects.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Projects {
  String id;
  String name;
  DateTime endDate;
  bool status;
  int progress;

  Projects({
    required this.id,
    required this.name,
    required this.endDate,
    required this.status,
    required this.progress,
  });

  factory Projects.fromRawJson(String str) =>
      Projects.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        id: json["id"],
        name: json["name"],
        endDate: DateTime.parse(json["endDate"]),
        status: json["status"],
        progress: json["progress"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "endDate": endDate.toIso8601String(),
        "status": status,
        "progress": progress,
      };
}
