import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_response.dart';
import '../models/user_roles_response.dart';
import 'api_service.dart';

class AuthService {
  static Future<UserResponse?> signIn(String username, String password) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/authentication/sign-in'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<bool> signUp(String username, String compania, String dni, String codColaborador, String password, String role) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/authentication/sign-up'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'compania': compania,
        'dni': dni,
        'cod_colaborador': codColaborador,
        'password': password,
        'roles': [role],
      }),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<List<String>> getUserRoles(int userId, String token) async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/users/$userId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return List<String>.from(json['roles'] ?? []);
    } else {
      return [];
    }
  }
}
