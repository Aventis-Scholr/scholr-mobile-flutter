import 'package:flutter/material.dart';

class ScholarshipsHome extends StatefulWidget {
  const ScholarshipsHome({super.key});

  @override
  State<ScholarshipsHome> createState() => _ScholarshipsHomeState();
}

class _ScholarshipsHomeState extends State<ScholarshipsHome> {

  // Colores personalizados
  final Color primaryBrown = const Color(0xFF765532);
  final Color lightBrown = const Color(0xFF9B7B5B);
  final Color darkBrown = const Color(0xFF523A23);
  final Color backgroundColor = const Color(0xFFDCF1F9);
  final Color textPrimaryColor = const Color(0xFF2D1810);
  final Color textSecondaryColor = const Color(0xFF5C4332);
  final Color deepBlue = const Color(0xFF2A3D66);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(),
    );
  }
}
