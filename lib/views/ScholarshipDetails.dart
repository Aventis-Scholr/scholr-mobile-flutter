import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholrflutter/components/CustomAppBar.dart';
import 'package:scholrflutter/models/apoderado.dart';
import 'package:scholrflutter/models/scholarship.dart';

import 'package:http/http.dart' as http;

import '../bloc/ApoderadosBloc.dart';
import '../bloc/ApoderadosEvent.dart';
import '../bloc/ApoderadosState.dart';
import '../repository/ApoderadoRepos.dart';



class ScholarshipDetails extends StatelessWidget {
  final Scholarship scholarship;

  const ScholarshipDetails({super.key, required this.scholarship});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ApoderadoBloc(
        repository: ApoderadoRepository(httpClient: http.Client()),
      )..add(FetchApoderados(scholarship.id)),
      child: ScholarshipDetailsView(scholarship: scholarship),
    );
  }
}

class ScholarshipDetailsView extends StatelessWidget {
  final Scholarship scholarship;

  const ScholarshipDetailsView({super.key, required this.scholarship});

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = const Color(0xFFDCF1F9);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(titleText: 'Beca'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                scholarship.name,
                style: const TextStyle(fontSize: 30.0),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1.7),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Requisitos:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...scholarship.requirements.map((req) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "- ${req.name}: ${req.description} ${req.isMandatory ? '(Obligatorio)' : '(Opcional)'}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                'Lista de Colaboradores',
                style: TextStyle(fontSize: 22.0),
              ),
            ),
            const SizedBox(height: 24),
            BlocBuilder<ApoderadoBloc, ApoderadoState>(
              builder: (context, state) {
                if (state is ApoderadoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ApoderadoLoaded) {
                  return Column(
                    children: state.apoderados.map((apoderado) {
                      return GestureDetector(
                        onTap: () {
                          // Handle apoderado tap here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Clicked on ${apoderado.name}')),
                          );
                        },
                        child: ApoderadoTile(apoderado: apoderado),
                      );
                    }).toList(),
                  );
                } else if (state is ApoderadoError) {
                  return Center(child: Text(state.message));
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

class ApoderadoTile extends StatelessWidget {
  final Apoderado apoderado;

  const ApoderadoTile({super.key, required this.apoderado});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 350,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1.5),
            ),
            child: Row(
              children: [
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    apoderado.name,
                    style: const TextStyle(fontSize: 23),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  height: 60,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFFf4c542),
                    border: Border(left: BorderSide(width: 1.5, color: Colors.black)),
                  ),
                  child: const Center(
                    child: Text(
                      "Ver",
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
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
