import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholrflutter/models/apoderado.dart';
import 'package:scholrflutter/models/postulacion.dart';
import 'package:scholrflutter/views/CollaboratorInfoScreen.dart';

import 'package:scholrflutter/views/LoginScreen.dart';
import 'package:scholrflutter/views/CompanySelectionScreen.dart';
import 'package:scholrflutter/views/PostulanteInfoScreen.dart';
import 'package:scholrflutter/views/PostulantList.dart';
import 'package:scholrflutter/views/ScholarshipDetails.dart';
import 'package:scholrflutter/views/ScholarshipsHome.dart';
import 'package:scholrflutter/views/SignUpScreen.dart';

import 'package:scholrflutter/viewmodels/login_viewmodel.dart';
import 'package:scholrflutter/viewmodels/signup_viewmodel.dart';
import 'package:scholrflutter/views/SolicitudRechazadaScreen.dart';
import 'package:scholrflutter/views/homeApoderado.dart';

import 'models/scholarship.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SignUpViewModel()),
      ],
      child: MaterialApp(
        title: 'Scholr Flutter',
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/CompanySelection': (context) => const CompanySelectionScreen(),
          '/register': (context) => const SignUpScreen(),
          '/home_apoderado': (context) => const homeApoderado(),
          '/info_apoderado': (context) {
            final dataApoderadoId = ModalRoute.of(context)!.settings.arguments as int;
            return CollaboratorInfoScreen(dataApoderadoId: dataApoderadoId);
          },
          '/info_postulante': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return PostulanteInfoScreen(
              postulacion: args['postulacion'] as Postulacion,
              apoderadoId: args['apoderadoId'] as int,
              apoderadoName: args['apoderadoName'] as String,
            );
          },
          '/solicitud_rechazada': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return SolicitudRechazadaScreen(
              postulacionId: args['postulacionId'] as int,
              apoderadoId: args['apoderadoId'] as int,
              apoderadoName: args['apoderadoName'] as String,
            );
          },
          '/scholarships': (context) => const ScholarshipsHome(),
          '/scholarshipdetails': (context) {
            final scholarship = ModalRoute.of(context)!.settings.arguments as Scholarship;
            return ScholarshipDetails(scholarship: scholarship);
          },
          '/postulantlist': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
            return PostulantList(
              apoderadoId: args['apoderadoId'] as int,
              apoderadoName: args['apoderadoName'] as String,
            );
          }
        },
      ),
    );
  }
}
