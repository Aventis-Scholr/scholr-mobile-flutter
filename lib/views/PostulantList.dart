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
                          child: PostulacionTile(postulacion: postulacion),
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

  const PostulacionTile({super.key, required this.postulacion});

  @override
  Widget build(BuildContext context) {
    final postulante = postulacion.postulante;
    final nombreCompleto = '${postulante.nombres} ${postulante.apellidos}';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/info_postulante", arguments: postulacion);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 350,
            decoration: BoxDecoration(
                color: Colors.white,
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
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Estado: ${postulacion.status}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Color(0xFFf4c542),
                      border: Border(
                          left: BorderSide(
                              width: 1.5,
                              color: Colors.black
                          )
                      )
                  ),
                  child: const Center(
                    child: Text(
                      "Ver",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
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
}