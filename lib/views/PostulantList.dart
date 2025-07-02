import 'package:flutter/material.dart';
import 'package:scholrflutter/components/CustomAppBar.dart';
import 'package:scholrflutter/models/apoderado.dart';

import '../models/postulante.dart';

class PostulantList extends StatefulWidget {
  const PostulantList({super.key});

  @override
  State<PostulantList> createState() => _PostulantListState();
}

class _PostulantListState extends State<PostulantList> {
  final Color backgroundColor = const Color(0xFFDCF1F9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(titleText: 'Beca'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 18.0),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
                'Postulantes de',
                style: TextStyle(
                    fontSize: 30.0,
                  fontWeight: FontWeight.bold
                )
            ),
          ),
          SizedBox(height: 30),
          PostulanteTile(postulante: Postulante())
        ],
      ),
    );
  }
}


class PostulanteTile extends StatelessWidget {
  final Postulante postulante;

  const PostulanteTile({super.key, required this.postulante});

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(width: 14),
                  Text(
                    "Nombre",
                    style: TextStyle(
                        fontSize: 23
                    ),
                  ),
                  SizedBox(width: 149),
                  Container(
                    height: 57,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color(0xFFf4c542),
                        border: Border(
                            left: BorderSide(
                                width: 1.5,
                                color: Colors.black
                            )
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Ver",
                              style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
