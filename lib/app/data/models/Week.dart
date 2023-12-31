class Week {
  final int week;

  Week({required this.week});

  factory Week.fromJson(Map<String, dynamic> json) {
    return Week(
      week: json['week'] ?? 0,
    );
  }
}