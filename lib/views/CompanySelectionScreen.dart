import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/signup_viewmodel.dart';


class CompanySelectionScreen extends StatefulWidget {
  const CompanySelectionScreen({super.key});

  @override
  State<CompanySelectionScreen> createState() => _CompanySelectionScreenState();
}

class _CompanySelectionScreenState extends State<CompanySelectionScreen> {
  String? selectedCompany;

  // Lista de empresas con su nombre y ruta de logo
  final List<Map<String, String>> companies = [
    {'logo': 'lib/images/backus.png', 'name': 'backus'},
    {'logo': 'lib/images/pepsico.png', 'name': 'pepsico'},
    {'logo': 'lib/images/nestle.png', 'name': 'nestle'},
    {'logo': 'lib/images/paraiso.png', 'name': 'paraiso'},
  ];

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFDCF1F9);
    const highlightColor = Color(0xFF2A3D66);
    const buttonColor = Color(0xFFFFD54F);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // Logo circular
              Container(
                width: 160,
                height: 160,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: highlightColor,
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
                  'lib/images/scholrlogo.png', // Asegúrate de incluir esta imagen en pubspec.yaml
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Elija la empresa a la\nque pertenece',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 24),

              // Lista scrollable
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: companies.map((company) {
                      final name = company['name']!;
                      final logoPath = company['logo']!;
                      final isSelected = selectedCompany == name;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            final viewModel = Provider.of<SignUpViewModel>(context, listen: false);
                            viewModel.compania = name;
                            viewModel.role = "ROLE_APODERADO"; // o el que corresponda
                            setState(() {
                              selectedCompany = name;
                              // Aquí llamaría a: viewModel.setCompany(name);
                              // y luego: viewModel.setRole("ROLE_APODERADO");
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            elevation: 4,
                            minimumSize: const Size.fromHeight(60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: isSelected
                                  ? const BorderSide(color: highlightColor, width: 2)
                                  : BorderSide.none,
                            ),
                          ),
                          child: Image.asset(
                            logoPath,
                            height: 28,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Botón continuar
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: selectedCompany != null
                      ? () {
                    Navigator.pushNamed(context, '/register'); // Ajusta ruta real
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    selectedCompany != null ? highlightColor : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
