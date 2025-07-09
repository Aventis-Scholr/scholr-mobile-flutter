import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/AcceptanceBloc.dart';
import '../repository/AcceptanceRepository.dart';
import '../models/postulacion.dart';

class PostulanteInfoScreen extends StatelessWidget {
  final Postulacion postulacion;
  final int apoderadoId;
  final String apoderadoName;

  const PostulanteInfoScreen({
    super.key,
    required this.postulacion,
    required this.apoderadoId,
    required this.apoderadoName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AcceptanceBloc(AcceptanceRepository()),
      child: Builder(
        builder: (context) {
          final postulante = postulacion.postulante;
          final contacto = postulante.contacto;
          final centroEstudios = postulante.centroEstudios;

          return Scaffold(
            backgroundColor: Colors.lightBlue.shade50,
            appBar: AppBar(
              backgroundColor: const Color(0xFF2A3D66),
              foregroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text("Postulante"),
            ),
            body: BlocListener<AcceptanceBloc, AcceptanceState>(
              listener: (context, state) {
                if (state is AcceptanceSuccess) {
                  Navigator.of(context).pushReplacementNamed(
                    '/postulantlist',
                    arguments: {
                      'apoderadoId': apoderadoId,
                      'apoderadoName': apoderadoName,
                    },
                  );
                } else if (state is AcceptanceFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                }
              },
              child: _buildContent(context, postulante, contacto, centroEstudios),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
      BuildContext context,
      Postulante postulante,
      Contacto contacto,
      CentroEstudios centroEstudios,
      ) {
    final fechaNacimiento = '${postulante.fechaNacimiento.day}/${postulante.fechaNacimiento.month}/${postulante.fechaNacimiento.year}';

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
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
            downloadField("DNI.pdf", postulacion.postulanteDni!,context),
          if (postulacion.postulanteLibretaNotas != null)
            downloadField("Cartilla de Notas.pdf", postulacion.postulanteLibretaNotas!,context),
          if (postulacion.postulanteConstLogroAprendizaje != null)
            downloadField("Constancia de Logros.pdf", postulacion.postulanteConstLogroAprendizaje!,context),
          if (postulacion.apoderadoDni != null)
            downloadField("DNI Apoderado.pdf", postulacion.apoderadoDni!,context),
          if (postulacion.apoderadoDeclaracionJurada != null)
            downloadField("Declaración Jurada.pdf", postulacion.apoderadoDeclaracionJurada!,context),

          const SizedBox(height: 8),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _downloadAllFiles(context),
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

          Row(
            children: [
              Expanded(
                child: BlocBuilder<AcceptanceBloc, AcceptanceState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is AcceptanceLoading
                          ? null
                          : () => _showAcceptConfirmationDialog(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A3D66),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: state is AcceptanceLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "Aceptar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      "/solicitud_rechazada",
                      arguments: {
                        'postulacionId': postulacion.id,
                        'apoderadoId': apoderadoId,
                        'apoderadoName': apoderadoName,
                      },
                    );
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
    );
  }

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

  Widget downloadField(String fileName, String url, BuildContext context) {
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
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () async {
              try {
                await _launchUrl(url, context);
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error al abrir el archivo: ${e.toString()}'),
                    ),
                  );
                }
              }
            },
            icon: const Icon(Icons.download),
            tooltip: 'Descargar archivo',
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    final uri = Uri.parse(url);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo abrir el enlace: ${e.toString()}'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
      debugPrint('Error launching URL: $e');
    }
  }

  void _showAcceptConfirmationDialog(BuildContext context) {
    final acceptanceBloc = context.read<AcceptanceBloc>();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Confirmar Aceptación"),
          content: const Text("¿Está seguro que desea aceptar esta postulación?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                acceptanceBloc.add(AcceptApplicationEvent(postulacion.id));
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void _downloadAllFiles(BuildContext context) {
    final files = [
      if (postulacion.postulanteDni != null)
        {'name': 'DNI.pdf', 'url': postulacion.postulanteDni!},
      if (postulacion.postulanteLibretaNotas != null)
        {'name': 'Cartilla de Notas.pdf', 'url': postulacion.postulanteLibretaNotas!},
      if (postulacion.postulanteConstLogroAprendizaje != null)
        {'name': 'Constancia de Logros.pdf', 'url': postulacion.postulanteConstLogroAprendizaje!},
      if (postulacion.apoderadoDni != null)
        {'name': 'DNI Apoderado.pdf', 'url': postulacion.apoderadoDni!},
      if (postulacion.apoderadoDeclaracionJurada != null)
        {'name': 'Declaración Jurada.pdf', 'url': postulacion.apoderadoDeclaracionJurada!},
    ];

    if (files.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay archivos para descargar')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Descargar todos los archivos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Se abrirán todas las descargas en el navegador:'),
              const SizedBox(height: 16),
              ...files.map((file) => ListTile(
                title: Text(file['name']!),
                trailing: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () => _launchUrl(file['url']!, context),
                ),
              )).toList(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}