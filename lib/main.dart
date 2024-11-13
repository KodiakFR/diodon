import 'package:diodon/bloc/connection_bloc.dart';
import 'package:diodon/bloc/dives_bloc.dart';
import 'package:diodon/bloc/dives_detail_bloc.dart';
import 'package:diodon/bloc/home_bloc.dart';
import 'package:diodon/bloc/participants_bloc.dart';
import 'package:diodon/bloc/register_bloc.dart';
import 'package:diodon/views/Connexion/connexion_view.dart';
import 'package:diodon/views/Dive/create_dive.dart';
import 'package:diodon/views/Dive/dive_detail.dart';
import 'package:diodon/views/Dive/upadate_dive.dart';
import 'package:diodon/views/Weekend/add_participants.dart';
import 'package:diodon/views/Weekend/creat_weekend.dart';
import 'package:diodon/views/Home/home_page.dart';
import 'package:diodon/views/Register/register_view.dart';
import 'package:diodon/views/Register/signature_dialog_view.dart';
import 'package:diodon/views/Weekend/detail_weekend.dart';
import 'package:diodon/views/Weekend/update_weekend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnexionBloc(Connexion.empty()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(Register.empty()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(Home.empty()),
        ),
        BlocProvider(
          create: (context) => ParticipantsBloc([]),
        ),
        BlocProvider(
          create: (context) => DivesBloc([]),
        ),
        BlocProvider(
          create: (context) => DiveDetailBloc(DiveDetailModel([], [])),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale("fr", "FR"),
        supportedLocales: const [Locale("fr", "FR")],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.orange,
          primarySwatch: Colors.orange,
        ),
        title: 'Diodon',
        routes: {
          "/connexion": (context) => const ConnexionView(),
          "/register": (context) => RegisterView(),
          "/signatureDialog": (context) => const SignatureDialog(),
          "/homePage": (context) => HomePage(),
          "/createWeekend": (context) => const CreateWeekend(),
          "/addParticipants": (context) => const AddParticipants(),
          "/weekendDetail": (context) => WeekendDetail(),
          "/createDive": (context) => const CreateDive(),
          "/diveDetail": (context) => const DiveDetail(),
          "/updateWeekend": (context) => const UpdateWeekend(),
          "/updateDive": (context) => const UpdateDive(),
        },
        home: const ConnexionView(),
      ),
    );
  }
}
