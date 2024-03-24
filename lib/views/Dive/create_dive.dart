// ignore_for_file: use_build_context_synchronously

import 'package:diodon/bloc/connection_bloc.dart';
import 'package:diodon/entities/dive.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../entities/weekend.dart';
import '../Widget/app_bar_custo.dart';

class CreateDive extends StatefulWidget {
  const CreateDive({Key? key}) : super(key: key);

  @override
  State<CreateDive> createState() => _CreateDiveState();
}

class _CreateDiveState extends State<CreateDive> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController constrollerDiveSite = TextEditingController();
  final TextEditingController controllerStartDate = TextEditingController();
  final TextEditingController controllerStartHour = TextEditingController();
  final TextEditingController controllerDP = TextEditingController();
  final TextEditingController controllerBoat = TextEditingController();
  final TextEditingController controllerCaptainName = TextEditingController();
  final TextEditingController controllerNbPerson = TextEditingController();
  final TextEditingController controllerNbDivers = TextEditingController();

  final IsarService isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    final weekend = ModalRoute.of(context)!.settings.arguments as Weekend;

    return Scaffold(
      appBar: const CustoAppBar("Création d'un plongée"),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            controller: constrollerDiveSite,
                            decoration: const InputDecoration(
                                hintText: 'Site de la coléra',
                                labelText: 'Site de plongée'),
                          ),
                          TextFormField(
                            controller: controllerStartDate,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today_rounded),
                              labelText: 'Selectionnez la date de la plongée',
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  controllerStartDate.text =
                                      DateFormat('dd/MM/yyyy')
                                          .format(pickedDate);
                                });
                              }
                            },
                          ),
                          TextFormField(
                            controller: controllerStartHour,
                            showCursor: true,
                            readOnly: true,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.calendar_today_rounded),
                              labelText:
                                  'Selectionnez l\'heure de début de plongée',
                            ),
                            onTap: () async {
                              TimeOfDay? pickedHour = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                builder: (BuildContext context, Widget? child) {
                                  return MediaQuery(
                                    data: MediaQuery.of(context)
                                        .copyWith(alwaysUse24HourFormat: true),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedHour != null) {
                                setState(() {
                                  var df = DateFormat("HH:mm");
                                  var dt = df.parse(pickedHour.format(context));
                                  controllerStartHour.text =
                                      DateFormat("HH:mm").format(dt);
                                });
                              }
                            },
                          ),
                          BlocBuilder<ConnexionBloc, Connexion>(
                            builder: (context, state) {
                              controllerDP.text =
                                  '${state.connectedUser!.firstName} ${state.connectedUser!.name}';
                              return TextFormField(
                                controller: controllerDP,
                                decoration: const InputDecoration(
                                  labelText: 'Nom du DP',
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFormField(
                              controller: controllerBoat,
                              decoration: const InputDecoration(
                                  labelText: 'Nom du bateau'),
                            ),
                            TextFormField(
                              controller: controllerCaptainName,
                              decoration: const InputDecoration(
                                  labelText: 'Nom du capitaine'),
                            ),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: controllerNbPerson,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText:
                                      'Nombre de personnes sur le bateau'),
                            ),
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: controllerNbDivers,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText:
                                      'Nombre de plongeurs sur le bateau'),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      DateTime date = DateTime(1970);
                      final List<Dive> dives =
                          await isarService.getAllDiveByWeekend(weekend);
                      //definition de la date de départ
                      if (controllerStartDate.text.isNotEmpty) {
                        int year = int.parse(
                            controllerStartDate.text.substring(6, 10));
                        int month =
                            int.parse(controllerStartDate.text.substring(3, 5));
                        int day =
                            int.parse(controllerStartDate.text.substring(0, 2));
                        date = DateTime(year, month, day);
                      }
                      if (controllerStartHour.text.isNotEmpty) {
                        int hour =
                            int.parse(controllerStartHour.text.substring(0, 2));
                        int minute =
                            int.parse(controllerStartHour.text.substring(3, 5));
                        date = date.add(Duration(hours: hour, minutes: minute));
                      }
                      Dive dive = Dive()
                        ..title = "Plongée N° ${dives.length + 1}"
                        ..divingSite = constrollerDiveSite.text
                        ..dateDepart = date
                        ..dp = controllerDP.text
                        ..boat = controllerBoat.text
                        ..captain = controllerCaptainName.text
                        ..nbPeople = controllerNbPerson.text.isEmpty
                            ? 0
                            : int.parse(controllerNbPerson.text)
                        ..nbDiver = controllerNbDivers.text.isEmpty
                            ? 0
                            : int.parse(controllerNbDivers.text)
                        ..weekend.value = weekend;

                      bool isCreate = await isarService.saveDive(weekend, dive);
                      if (isCreate == true) {
                        Navigator.pushNamed(context, "/diveDetail",
                            arguments: dive);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Une plongée avec le même nom existe déjà',
                            textAlign: TextAlign.center,
                          ),
                          backgroundColor: Colors.red,
                        ));
                      }
                    }
                  },
                  child: const Text("Valider"))
            ],
          ),
        )),
      ),
    );
  }
}
