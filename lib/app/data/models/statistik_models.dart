class StatistikJson {
  final int code;
  final StatistikData data;

  StatistikJson({required this.code, required this.data});

  factory StatistikJson.fromJson(Map<String, dynamic> json) {
    return StatistikJson(
      code: json['code'] ?? 0,
      data: StatistikData.fromJson(json['data'] ?? {}),
    );
  }
}

class StatistikData {
  final String name;
  final String description;
  final String pmName;
  final dynamic progress;
  final DateTime createdAt;
  final DateTime startDate;
  final DateTime endDate;
  final bool status;

  StatistikData({
    required this.name,
    required this.description,
    required this.pmName,
    dynamic progress,
    required this.createdAt,
    required this.startDate,
    required this.endDate,
    required this.status,
  }) : progress = progress;

  factory StatistikData.fromJson(Map<String, dynamic> json) {
    return StatistikData(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      pmName: json['pmName'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      startDate: DateTime.parse(json['startDate'] ?? ''),
      endDate: DateTime.parse(json['endDate'] ?? ''),
      progress: json['progress'],
      status: json['status'] ?? false,
    );
  }
}

// khusus untuk PM
// project_model.dart
class Project {
  String id;
  String name;
  String startDate;
  String endDate;
  bool status;
  dynamic progress;
  List<Detail> details;

  Project({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.progress,
    required this.details,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      status: json['status'],
      progress: json['progress'],
      details: (json['details'] as List)
          .map((detail) => Detail.fromJson(detail))
          .toList(),
    );
  }
}

// detail_model.dart
class Detail {
  String crewId;
  String crewName;
  String crewRole;
  dynamic productivity;
  dynamic contribution;

  Detail({
    required this.crewId,
    required this.crewName,
    required this.crewRole,
    required this.productivity,
    required this.contribution,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      crewId: json['crewId'],
      crewName: json['crewName'],
      crewRole: json['crewRole'],
      productivity: json['productivity'],
      contribution: json['contribution'],
    );
  }
}

// statistik crew month day
class StatistikDataMonthResponse {
  final dynamic code;
  final StatistikDataMonth data;

  StatistikDataMonthResponse({required this.code, required this.data});

  factory StatistikDataMonthResponse.fromJson(Map<String, dynamic> json) {
    return StatistikDataMonthResponse(
      code: json['code'] ?? 0,
      data: StatistikDataMonth.fromJson(json['data'] ?? {}),
    );
  }
}

class StatistikDataMonth {
  final DateTime? date;
  final dynamic productivity;
  final dynamic contribution;

  StatistikDataMonth({
    this.date,
    required this.productivity,
    required this.contribution,
  });

  factory StatistikDataMonth.fromJson(Map<String, dynamic> json) {
    return StatistikDataMonth(
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      productivity: json['productivity'] ?? 0.0,
      contribution: json['contribution'] ?? 0.0,
    );
  }
}

class StatistikDataLastWeekResponse {
  final dynamic code;
  final StatistikDataMonth data;

  StatistikDataLastWeekResponse({required this.code, required this.data});

  factory StatistikDataLastWeekResponse.fromJson(Map<String, dynamic> json) {
    return StatistikDataLastWeekResponse(
      code: json['code'] ?? 0,
      data: StatistikDataMonth.fromJson(json['data'] ?? {}),
    );
  }
}

class StatistikDataLastWeek {
  final DateTime? date;
  final dynamic productivity;
  final dynamic contribution;

  StatistikDataLastWeek({
    this.date,
    required this.productivity,
    required this.contribution,
  });

  factory StatistikDataLastWeek.fromJson(Map<String, dynamic> json) {
    return StatistikDataLastWeek(
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      productivity: json['productivity'] ?? 0.0,
      contribution: json['contribution'] ?? 0.0,
    );
  }
}

class StatistikDataDayResponse {
  final dynamic code;
  final StatistikDataDay data;

  StatistikDataDayResponse({required this.code, required this.data});

  factory StatistikDataDayResponse.fromJson(Map<String, dynamic> json) {
    return StatistikDataDayResponse(
      code: json['code'] ?? 0,
      data: StatistikDataDay.fromJson(json['data'] ?? {}),
    );
  }
}

class StatistikDataDay {
  final DateTime? date;
  final dynamic productivity;
  final dynamic contribution;

  StatistikDataDay({
    this.date,
    required this.productivity,
    required this.contribution,
  });

  factory StatistikDataDay.fromJson(Map<String, dynamic> json) {
    return StatistikDataDay(
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      productivity: json['productivity'] ?? 0.0,
      contribution: json['contribution'] ?? 0.0,
    );
  }
}

// data quarter
class StatistikDataQuarterResponse {
  final dynamic code;
  final StatistikDataDay data;

  StatistikDataQuarterResponse({required this.code, required this.data});

  factory StatistikDataQuarterResponse.fromJson(Map<String, dynamic> json) {
    return StatistikDataQuarterResponse(
      code: json['code'] ?? 0,
      data: StatistikDataDay.fromJson(json['data'] ?? {}),
    );
  }
}

class StatistikDataQuarter {
  final DateTime? date;
  final dynamic productivity;
  final dynamic contribution;

  StatistikDataQuarter({
    this.date,
    required this.productivity,
    required this.contribution,
  });

  factory StatistikDataQuarter.fromJson(Map<String, dynamic> json) {
    return StatistikDataQuarter(
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      productivity: json['productivity'] ?? 0.0,
      contribution: json['contribution'] ?? 0.0,
    );
  }
}
