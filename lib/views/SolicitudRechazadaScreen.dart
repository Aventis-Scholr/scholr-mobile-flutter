import 'package:flutter/material.dart';

class SolicitudRechazadaScreen extends StatelessWidget {
  const SolicitudRechazadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A3D66),
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 30),
          onPressed: () {},
        ),
        title: const Row(
          children: [
            SizedBox(width: 16),
            Text(
              "Rechazo",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12), // Espacio entre AppBar y título
              // TITULO PRINCIPAL
              const Center(
                child: Text(
                  "Rechazo de solicitud",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 72),

              // CAMPOS DE LECTURA
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Mensaje de rechazo:",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      TextFormField(
                        maxLines: 15,
                        decoration: const InputDecoration(
                          hintText: 'Especifique las razones del rechazo de la solicitud.',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 72),

              // BOTON ENVIAR
              Center(
                child: SizedBox(
                  width: 130, // Aquí forzamos el ancho
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para enviar
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text(
                              "Mensaje enviado",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: const Text("El mensaje ha sido enviado exitosamente."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();

                                  // Redireccionamiento
                                  Future.delayed(Duration(milliseconds: 100), () {
                                    Navigator.of(context).pushReplacementNamed('/home'); // Cambiar '/home' por la ruta deseada
                                  });
                                },
                                child: const Text(
                                  "Volver",
                                  style: TextStyle(
                                    color: Color(0xFF2A3D66),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2A3D66),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      "Enviar",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}