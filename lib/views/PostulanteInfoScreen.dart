import 'package:flutter/material.dart';
import '../models/postulacion.dart';

class PostulanteInfoScreen extends StatelessWidget {
  final Postulacion postulacion;

  const PostulanteInfoScreen({super.key, required this.postulacion});

  @override
  Widget build(BuildContext context) {
    final postulante = postulacion.postulante;
    final contacto = postulante.contacto;
    final centroEstudios = postulante.centroEstudios;

    // Formatear fecha de nacimiento
    final fechaNacimiento = '${postulante.fechaNacimiento.day}/${postulante.fechaNacimiento.month}/${postulante.fechaNacimiento.year}';

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
              "Postulante",
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
              const SizedBox(height: 12),
              // TITULO PRINCIPAL
              Center(
                child: Text(
                  "Datos de ${postulante.nombres} ${postulante.apellidos}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // CAMPOS DE LECTURA
              readonlyField("Nombres", postulante.nombres),
              readonlyField("Apellidos", postulante.apellidos),
              readonlyField("DNI", postulante.dni.toString()),
              readonlyField("Fecha de Nacimiento", fechaNacimiento),

              sectionSubtitle("Contacto"),
              readonlyField("Correo", contacto.correo),
              readonlyField("Celular", contacto.celular.toString()),

              sectionSubtitle("Centro de Estudios"),
              readonlyField("Nombre del C.E.", centroEstudios.nombre),
              readonlyField("Tipo", centroEstudios.tipo),
              readonlyField("Nivel", centroEstudios.nivel),
              readonlyField("Departamento", centroEstudios.departamento),
              readonlyField("Provincia", centroEstudios.provincia),
              readonlyField("Distrito", centroEstudios.distrito),

              sectionSubtitle("Archivos Adjuntos"),
              if (postulacion.postulanteDni != null)
                downloadField("DNI.pdf"),
              if (postulacion.postulanteLibretaNotas != null)
                downloadField("Cartilla de Notas.pdf"),
              if (postulacion.postulanteConstLogroAprendizaje != null)
                downloadField("Constancia de Logros.pdf"),
              if (postulacion.apoderadoDni != null)
                downloadField("DNI Apoderado.pdf"),
              if (postulacion.apoderadoDeclaracionJurada != null)
                downloadField("Declaración Jurada.pdf"),

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
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción para aceptar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A3D66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Acción para rechazar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        "Rechazar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
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
          fillColor: const Color(0xFFE0E0E0),
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