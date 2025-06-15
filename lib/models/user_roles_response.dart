class UserRolesResponse {
  final int id;
  final String username;
  final List<String> roles;

  UserRolesResponse({required this.id, required this.username, required this.roles});

  factory UserRolesResponse.fromJson(Map<String, dynamic> json) {
    return UserRolesResponse(
      id: json['id'],
      username: json['username'],
      roles: List<String>.from(json['roles'] ?? []),
    );
  }
}
