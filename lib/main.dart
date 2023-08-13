import 'package:diodon/views/Connexion/connexion_view.dart';
import 'package:diodon/views/Register/register_view.dart';
import 'package:diodon/views/Register/signature_dialog_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diodon',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        "/connexion": (context) => const ConnexionView(),
        "/register": (context) => const RegisterView(),
      },
      home: const SignatureDialog(),
    );
  }
}
