import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/preference_manager.dart';

class LoginViewModel with ChangeNotifier {
  String username = '';
  String password = '';
  String? errorMessage;
  bool loginSuccess = false;

  void setUsername(String value) => username = value;
  void setPassword(String value) => password = value;

  Future<void> signIn() async {
    final userResponse = await AuthService.signIn(username, password);
    if (userResponse != null) {
      final userRoles = await AuthService.getUserRoles(userResponse.id, userResponse.token);
      await PreferenceManager.saveUser(userResponse.id, userResponse.username, userResponse.token, userRoles);
      loginSuccess = true;
      errorMessage = null;
    } else {
      errorMessage = 'Usuario o contraseña incorrectos.';
      loginSuccess = false;
    }
    notifyListeners();
  }
  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}