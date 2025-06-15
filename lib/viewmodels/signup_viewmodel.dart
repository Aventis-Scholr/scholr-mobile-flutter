import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class SignUpViewModel with ChangeNotifier {
  String username = '';
  String compania = '';
  String dni = '';
  String codColaborador = '';
  String password = '';
  String confirmPassword = '';
  String role = '';
  String? errorMessage;
  bool signupSuccess = false;

  void resetState() {
    username = '';
    compania = '';
    dni = '';
    codColaborador = '';
    password = '';
    confirmPassword = '';
    signupSuccess = false;
    errorMessage = null;
    notifyListeners();
  }

  Future<void> signUp() async {
    if (password != confirmPassword) {
      errorMessage = 'Las contraseñas no coinciden';
      signupSuccess = false;
    } else {
      final success = await AuthService.signUp(username, compania, dni, codColaborador, password, role);
      if (success) {
        signupSuccess = true;
        errorMessage = null;
      } else {
        signupSuccess = false;
        errorMessage = 'Error en el registro';
      }
    }
    notifyListeners();
  }
  void clearError() {
    errorMessage = null;
    notifyListeners();
  }
}
