import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:scholrflutter/views/LoginScreen.dart';
import 'package:scholrflutter/views/CompanySelectionScreen.dart';
import 'package:scholrflutter/views/SignUpScreen.dart';

import 'package:scholrflutter/viewmodels/login_viewmodel.dart';
import 'package:scholrflutter/viewmodels/signup_viewmodel.dart';
import 'package:scholrflutter/views/homeApoderado.dart';

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
          '/home_apoderado':(context) => const homeApoderado(),
        },
      ),
    );
  }
}
