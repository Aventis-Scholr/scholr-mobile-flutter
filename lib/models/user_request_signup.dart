class UserRequestSignUp {
  final String username;
  final String compania;
  final String dni;
  final String codColaborador;
  final String password;
  final List<String> roles;

  UserRequestSignUp({
    required this.username,
    required this.compania,
    required this.dni,
    required this.codColaborador,
    required this.password,
    required this.roles,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'compania': compania,
      'dni': dni,
      'cod_colaborador': codColaborador,
      'password': password,
      'roles': roles,
    };
  }
}
