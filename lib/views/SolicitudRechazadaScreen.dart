import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/RechazoBloc.dart';
import '../repository/RechazoRepository.dart';

class SolicitudRechazadaScreen extends StatelessWidget {
  final int postulacionId;
  final TextEditingController _reporteController = TextEditingController();

  SolicitudRechazadaScreen({super.key, required this.postulacionId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RechazoBloc(RechazoRepository()),
      child: Scaffold(
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
        body: BlocListener<RechazoBloc, RechazoState>(
          listener: (context, state) {
            if (state is RechazoSuccess) {
              _mostrarDialogoExito(context);
            } else if (state is RechazoFailure) {
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

                  Center(
                    child: BlocBuilder<RechazoBloc, RechazoState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: 130,
                          child: ElevatedButton(
                            onPressed: state is RechazoLoading
                                ? null
                                : () {
                              final reporte = _reporteController.text.trim();
                              if (reporte.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Por favor ingrese un mensaje de rechazo')),
                                );
                                return;
                              }
                              context.read<RechazoBloc>().add(
                                RechazarPostulacionEvent(
                                  postulacionId: postulacionId,
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
                            child: state is RechazoLoading
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
            "Solicitud rechazada",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text("La solicitud ha sido rechazada exitosamente."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Regresar a /postulantlist
                Navigator.of(context).pushReplacementNamed('/postulantlist');
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