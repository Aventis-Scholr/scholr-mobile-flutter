class UserRequestSignIn {
  final String username;
  final String password;

  UserRequestSignIn({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}