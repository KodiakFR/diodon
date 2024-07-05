// ignore_for_file: use_build_context_synchronously
import 'package:diodon/bloc/connection_bloc.dart';
import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../entities/dive.dart';
import '../views/PDF/pdf.dart';

class HomeBloc extends Cubit<Home> {
  HomeBloc(Home initialState) : super(initialState);
  final IsarService isarService = IsarService();

  void addWeekends(List<Weekend> weekends) {
    state.weekends = weekends;
    emit(state);
  }

  void removeWeekend(Weekend weekend) async {
    bool result = await isarService.deleteWeekend(weekend);
    if (result == true) {
      Home newState = state.copyWith(weekends: state.weekends);
      newState.weekends!.remove(weekend);
      emit(newState);
    }
  }

  Future<Object> saveFile(BuildContext context, Weekend weekend) async {
    bool isValided = false;
    final ConnexionBloc userBloc = BlocProvider.of<ConnexionBloc>(context);
    List<Participant> participants =
        await isarService.getParticipantsFromWeekend(weekend.id!);
    for (var participant in participants) {
      if (participant.type!.isEmpty ||
          participant.firstName!.isEmpty ||
          participant.name!.isEmpty) {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Le nom ou le prénom ou le type de certains participants ne sont pas renseignés",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      }
      if ((participant.type == 'Plongeur' || participant.type == "Encadrant") &&
          (participant.diveLevel!.isEmpty || participant.aptitude!.isEmpty)) {
        return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "L'aptitude ou le niveau de certain plongeurs ou encadrants ne sont pas renseigné",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      }
    }

    List<Dive> dives = await isarService.getAllDiveByWeekend(weekend);
    for (var dive in dives) {
      if (dive.divingSite.isEmpty ||
          dive.boat.isEmpty ||
          dive.captain.isEmpty ||
          dive.dateDepart == DateTime(1970, 1, 1) ||
          dive.dp.isEmpty ||
          dive.nbDiver == 0 ||
          dive.nbPeople == 0) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "La ${dive.title} n'est pas correctement renseignée. Certains champs sont vide",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      }
      if (dive.dateDepart.isBefore(weekend.start) ||
          dive.dateDepart.isAfter(weekend.end.add(const Duration(days: 1)))) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "La date de ${dive.title} n'est pas inclus dans la date du week-end",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      }
      if ("${userBloc.state.connectedUser!.firstName} ${userBloc.state.connectedUser!.name}" !=
          dive.dp) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "La personne connecté n'est pas le DP de ${dive.title}, seul le DP peut générer le PDF",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ));
      }
      final List<DiveGroup> divegroups =
          await isarService.getAllDiveGroupForDive(dive);
      for (var diveGroup in divegroups) {
        if (diveGroup.participants.isEmpty) {
          return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "La ${diveGroup.title} de la ${dive.title} est vide. Veuillez la supprimer",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ));
        }
        if (diveGroup.divingStop!.isEmpty ||
            diveGroup.dpDeep!.isEmpty ||
            diveGroup.dpTime!.isEmpty ||
            diveGroup.realDeep!.isEmpty ||
            diveGroup.realTime!.isEmpty ||
            (diveGroup.standAlone! == false && diveGroup.supervised == false)) {
          return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Les paramètres de la ${diveGroup.title} de la ${dive.title} ne sont pas toutes renseignés",
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
    isValided = true;
    if (isValided) {
      final bytes = await generatePdf(weekend, context);
      final appDocDir = await getApplicationDocumentsDirectory();
      final appDocPath = appDocDir.path;
      String? resultString = await FileSaver.instance.saveAs(
          name: "Fiche de sécurité du ${weekend.title}",
          bytes: bytes,
          filePath: appDocPath,
          ext: "pdf",
          mimeType: MimeType.other);
      if (resultString != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Le PDF a été correctement généré",
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ));
      }
    }
    return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "Une erreur c'est produite veuillez recommencer",
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    ));
  }
}

class Home {
  List<Weekend>? weekends;

  Home(this.weekends);

  Home.empty();

  Home copyWith({final List<Weekend>? weekends}) {
    return Home(weekends ?? this.weekends);
  }
}
