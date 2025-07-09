import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholrflutter/models/scholarship.dart';
import 'package:scholrflutter/views/ScholarshipDetails.dart';
import '../bloc/RechazoAllBloc.dart';
import '../components/CustomAppBar.dart';
import '../repository/RechazoAllRepository.dart';

class RechazoAllScreen extends StatelessWidget {
  final int apoderadoId;
  final TextEditingController _reporteController = TextEditingController();

  RechazoAllScreen({super.key, required this.apoderadoId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RechazoAllBloc(RechazoAllRepository()),
      child: Scaffold(
        backgroundColor: Colors.lightBlue.shade50,
        appBar: CustomAppBar(titleText: 'Rechazo Masivo'),
        body: BlocListener<RechazoAllBloc, RechazoAllState>(
          listener: (context, state) {
            if (state is RechazoAllSuccess) {
              _mostrarDialogoExito(context);
            } else if (state is RechazoAllFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      "Rechazo masivo de postulaciones",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 72),

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
                            controller: _reporteController,
                            maxLines: 15,
                            decoration: const InputDecoration(
                              hintText: 'Especifique las razones del rechazo de todas las postulaciones.',
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

                  Center(
                    child: BlocBuilder<RechazoAllBloc, RechazoAllState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: state is RechazoAllLoading
                                ? null
                                : () {
                              final reporte = _reporteController.text.trim();
                              if (reporte.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Por favor ingrese un mensaje de rechazo')),
                                );
                                return;
                              }
                              context.read<RechazoAllBloc>().add(
                                RechazarAllPostulacionesEvent(
                                  apoderadoId: apoderadoId,
                                  reporte: reporte,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2A3D66),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                            ),
                            child: state is RechazoAllLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                              "Enviar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarDialogoExito(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Postulaciones rechazadas",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("Todas las postulaciones han sido rechazadas exitosamente."),
          actions: [
            TextButton(
              onPressed: () {
                final route = ModalRoute.of(context);
                final arguments = route?.settings.arguments as Map<String, dynamic>?;

                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Regresar a la pantalla anterior

                if (arguments != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => ScholarshipDetailsView(
                        scholarship: arguments["scholarship"] as Scholarship,
                      ),
                    ),
                  );
                }
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
  }
}