class Team {
  String id;
  String username;
  String email;
  String crewRole;

  Team({
    required this.id,
    required this.username,
    required this.email,
    required this.crewRole,
  });

  factory Team.fromJson(Map<String, dynamic> json) => Team(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        crewRole: json["crewRole"],
      );
}
