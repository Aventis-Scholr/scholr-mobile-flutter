import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholrflutter/components/CustomAppBar.dart';
import 'package:scholrflutter/models/apoderado.dart';
import 'package:scholrflutter/models/postulacion.dart';

import '../bloc/PostulacionBloc.dart';
import '../repository/ApplicationRepos.dart';

class PostulantList extends StatefulWidget {
  final int apoderadoId;
  final String apoderadoName;

  const PostulantList({
    super.key,
    required this.apoderadoId,
    required this.apoderadoName,
  });

  @override
  State<PostulantList> createState() => _PostulantListState();
}

class _PostulantListState extends State<PostulantList> {
  final Color backgroundColor = const Color(0xFFDCF1F9);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostulacionBloc(PostulacionRepository())
        ..add(FetchPostulacionesEvent(widget.apoderadoId)),
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: CustomAppBar(titleText: 'Postulaciones'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 18.0),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                  'Postulaciones de ${widget.apoderadoName}',
                  style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            const SizedBox(height: 30),
            BlocBuilder<PostulacionBloc, PostulacionState>(
              builder: (context, state) {
                if (state is PostulacionLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostulacionError) {
                  return Center(child: Text(state.message));
                } else if (state is PostulacionLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.postulaciones.length,
                      itemBuilder: (context, index) {
                        final postulacion = state.postulaciones[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: PostulacionTile(postulacion: postulacion, apoderadoId: widget.apoderadoId, apoderadoName: widget.apoderadoName),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PostulacionTile extends StatelessWidget {
  final Postulacion postulacion;
  final int apoderadoId;
  final String apoderadoName;

  const PostulacionTile({super.key, required this.postulacion, required this.apoderadoId, required this.apoderadoName});

  @override
  Widget build(BuildContext context) {
    // No mostrar postulaciones con estado "SINENVIAR"
    if (postulacion.status == 'SINENVIAR') {
      return const SizedBox.shrink();
    }

    final postulante = postulacion.postulante;
    final nombreCompleto = '${postulante.nombres} ${postulante.apellidos}';

    // Determinar estilos según el estado
    final statusStyle = _getStatusStyle(postulacion.status);
    final isDisabled = postulacion.status != 'PENDIENTE';
    final tileColor = isDisabled ? Colors.grey.shade300 : Colors.white;
    final textColor = isDisabled ? Colors.grey.shade600 : Colors.black;

    return GestureDetector(
      onTap: isDisabled
          ? null
          : () {
        Navigator.pushNamed(
            context,
            "/info_postulante",
          arguments: {
            'postulacion': postulacion,
            'apoderadoId': apoderadoId,
            'apoderadoName': apoderadoName,
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 350,
            decoration: BoxDecoration(
                color: tileColor,
                border: Border.all(
                    color: Colors.black,
                    width: 1.5
                )
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nombreCompleto,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          _getStatusIcon(postulacion.status),
                          const SizedBox(width: 4),
                          Text(
                            'Estado: ${postulacion.status}',
                            style: statusStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                      color: isDisabled ? Colors.grey.shade400 : const Color(0xFFf4c542),
                      border: const Border(
                          left: BorderSide(
                              width: 1.5,
                              color: Colors.black
                          )
                      )
                  ),
                  child: Center(
                    child: Text(
                      "Ver",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDisabled ? Colors.grey.shade700 : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Método para obtener el ícono según el estado
  Widget _getStatusIcon(String status) {
    switch (status) {
      case 'RECHAZADO':
        return const Icon(Icons.cancel, color: Colors.red, size: 16);
      case 'APROBADO':
        return const Icon(Icons.check_circle, color: Colors.green, size: 16);
      case 'PENDIENTE':
        return const Icon(Icons.access_time, color: Colors.blue, size: 16);
      case 'EN REVISION':
        return const Icon(Icons.visibility, color: Colors.orange, size: 16);
      default:
        return const Icon(Icons.help_outline, color: Colors.grey, size: 16);
    }
  }

  // Método para obtener el estilo de texto según el estado
  TextStyle _getStatusStyle(String status) {
    Color color;
    FontWeight weight = FontWeight.bold;

    switch (status) {
      case 'RECHAZADO':
        color = Colors.red;
        break;
      case 'APROBADO':
        color = Colors.green;
        break;
      case 'PENDIENTE':
        color = Colors.blue;
        break;
      case 'EN REVISION':
        color = Colors.orange;
        break;
      default:
        color = Colors.grey;
        weight = FontWeight.normal;
    }

    return TextStyle(
      fontSize: 14,
      color: color,
      fontWeight: weight,
    );
  }
}