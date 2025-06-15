import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholrflutter/utils/preference_manager.dart';
import '../viewmodels/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  // Colores personalizados
  final Color primaryBrown = const Color(0xFF765532);
  final Color lightBrown = const Color(0xFF9B7B5B);
  final Color darkBrown = const Color(0xFF523A23);
  final Color backgroundColor = const Color(0xFFDCF1F9);
  final Color textPrimaryColor = const Color(0xFF2D1810);
  final Color textSecondaryColor = const Color(0xFF5C4332);
  final Color deepBlue = const Color(0xFF2A3D66);

  void _login(BuildContext context) async {
    final viewModel = Provider.of<LoginViewModel>(context, listen: false);
    viewModel.setUsername(usernameController.text);
    viewModel.setPassword(passwordController.text);
    await viewModel.signIn();

    if (viewModel.loginSuccess) {
      final roles = await PreferenceManager.getUserRoles();
      if (roles != null && roles.contains("ROLE_APODERADO")) {
        Navigator.pushReplacementNamed(context, '/home_apoderado');
      } else if (roles != null && roles.contains("ROLE_DOCENTE")) {
        Navigator.pushReplacementNamed(context, '/home_docente');
      }
      // Agrega más roles si es necesario
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo circular
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    color: deepBlue,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'lib/images/scholrlogo.png', // Asegúrate de que la imagen esté en esta ruta
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    fontSize: 16,
                    color: textSecondaryColor,
                    fontFamily: 'Cabin', // Agrega fuente si la usas
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textPrimaryColor,
                    fontFamily: 'Cabin',
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryBrown),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryBrown),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _login(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: deepBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/CompanySelection'); // Cambia por tu ruta real
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '¿No tienes una cuenta? ',
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Crear cuenta',
                          style: TextStyle(
                            color: primaryBrown,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (viewModel.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: AlertDialog(
                      title: const Text('Error de inicio de sesión'),
                      content: Text(
                        viewModel.errorMessage!,
                        style: TextStyle(color: textSecondaryColor),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            viewModel.clearError(); // Debes crear este método
                          },
                          child: Text('Entendido', style: TextStyle(color: primaryBrown)),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
