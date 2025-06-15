class UserResponse {
  final int id;
  final String username;
  final String token;

  UserResponse({required this.id, required this.username, required this.token});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json['id'],
      username: json['username'],
      token: json['token'],
    );
  }
}