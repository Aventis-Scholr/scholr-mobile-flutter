import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/signup_viewmodel.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  // Controladores de campos
  final usernameController = TextEditingController();
  final dniController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final Color primaryBrown = const Color(0xFF765532);
  final Color backgroundColor = const Color(0xFFDCF1F9);
  final Color textPrimaryColor = const Color(0xFF2D1810);
  final Color textSecondaryColor = const Color(0xFF5C4332);
  final Color deepBlue = const Color(0xFF2A3D66);

  void _signUp(BuildContext context) async {
    final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
    viewModel
      ..username = usernameController.text
      ..dni = dniController.text
      ..codColaborador = codeController.text
      ..password = passwordController.text
      ..confirmPassword = confirmPasswordController.text;

    await viewModel.signUp();

    if (viewModel.signupSuccess) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
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
                    'lib/images/scholrlogo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 24),
                Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    fontSize: 16,
                    color: textSecondaryColor,
                    fontFamily: 'Cabin',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Crear Cuenta',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: textPrimaryColor,
                    fontFamily: 'Cabin',
                  ),
                ),
                const SizedBox(height: 24),

                // Campos de texto
                _buildTextField('Usuario', usernameController),
                const SizedBox(height: 16),
                _buildTextField('DNI', dniController),
                const SizedBox(height: 16),
                _buildTextField('Código de colaborador', codeController),
                const SizedBox(height: 16),
                _buildTextField('Contraseña', passwordController, isPassword: true),
                const SizedBox(height: 16),
                _buildTextField('Confirmar Contraseña', confirmPasswordController, isPassword: true),

                const SizedBox(height: 24),

                // Botón Crear Cuenta
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () => _signUp(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: deepBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Crear Cuenta',
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
                    Navigator.pushNamed(context, '/login');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: '¿Ya tienes una cuenta? ',
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: 'Inicia sesión',
                          style: TextStyle(
                            color: primaryBrown,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (viewModel.errorMessage != null) ...[
                  const SizedBox(height: 24),
                  AlertDialog(
                    title: const Text('Error de registro'),
                    content: Text(
                      viewModel.errorMessage!,
                      style: TextStyle(color: textSecondaryColor),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          viewModel.clearError(); // asegúrate de tener este método en el ViewModel
                        },
                        child: Text(
                          'Entendido',
                          style: TextStyle(color: primaryBrown),
                        ),
                      )
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryBrown),
        ),
      ),
    );
  }
}
