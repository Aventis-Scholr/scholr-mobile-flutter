import 'package:flutter/material.dart';

class CollaboratorInfoScreen extends StatelessWidget {
  const CollaboratorInfoScreen({super.key});

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
            const SizedBox(height: 12), // Espacio entre AppBar y título
            SizedBox(width: 16),
            Text(
              "Colaborador",
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
              // TITULO PRINCIPAL
              const Center(
                child: Text(
                  "Datos de Juan Quispe",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // CAMPOS DE LECTURA
              readonlyField("Nombres", "Juan Orlando"),
              readonlyField("Apellidos", "Quispe Saavedra"),
              readonlyField("DNI", "72209725"),
              readonlyField("Fecha de Nacimiento", "13/05/1996"),

              sectionSubtitle("Contacto"),
              readonlyField("Correo", "juan.quispe@gmail.com"),
              readonlyField("Celular", "924565781"),

              sectionSubtitle("Abono"),
              readonlyField("Entidad Bancaria", "Banco Pichincha"),
              readonlyField("Número de Cuenta", "1800928345"),
              readonlyField("CCI", "365"),

              sectionSubtitle("Domicilio"),
              readonlyField("Dirección", "Calle 28 de Julio 476, Santa..."),
              readonlyField("Departamento", "Lima"),
              readonlyField("Provincia", "Lima"),
              readonlyField("Distrito", "Comas"),

              sectionSubtitle("Información Laboral"),
              readonlyField("Tipo de colaborador", "Pasante"),
              readonlyField("Cargo", "Inspector"),
              readonlyField("Sede", "ATE"),
              readonlyField("Local", "ATE"),
              readonlyField("Ingreso", "14/05/2015"),

              sectionSubtitle("Archivos Adjuntos"),
              downloadField("DNI.pdf"),
              downloadField("Foto..."),
              downloadField("Documento 3"),

              const SizedBox(height: 8),

              // BOTÓN "Descargar todo"
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Acción para descargar todo
                  },
                  icon: const Icon(Icons.download, color: Colors.black),
                  label: const Text(
                    "Descargar todo",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black38),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),

              const SizedBox(height: 24),


              // BOTONES ACEPTAR Y RECHAZAR
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      label: const Text(
                        "Aceptar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A3D66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        // Acción para aceptar
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      label: const Text(
                        "Rechazar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A3D66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                      onPressed: () {
                        // Acción para rechazar
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // CAMPO SOLO LECTURA
  Widget readonlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: value,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color(0xFFE0E0E0), // fondo gris claro
        ),
      ),
    );
  }

  // SUBTÍTULOS
  Widget sectionSubtitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          color: Colors.black,
        ),
      ),
    );
  }

  // DESCARGA DE ARCHIVOS
  Widget downloadField(String fileName) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            fileName,
            style: const TextStyle(fontSize: 16),
          ),
          IconButton(
            onPressed: () {
              // Acción de descarga
            },
            icon: const Icon(Icons.download),
          ),
        ],
      ),
    );
  }
}
