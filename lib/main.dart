import 'package:diodon/bloc/user_bloc.dart';
import 'package:diodon/views/Connexion/connexion_view.dart';
import 'package:diodon/views/Home/home_page.dart';
import 'package:diodon/views/Register/register_view.dart';
import 'package:diodon/views/Register/signature_dialog_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'entities/user.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(User.empty()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Diodon',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: {
          "/connexion": (context) => ConnexionView(),
          "/register": (context) => RegisterView(),
          "/signatureDialog": (context) => const SignatureDialog(),
          "/homePage":(context) => const HomePage(),
        },
        home:  ConnexionView(),
      ),
    );
  }
}
