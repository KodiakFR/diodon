// ignore_for_file: use_build_context_synchronously

import 'package:diodon/entities/dive.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../Widget/app_bar_custo.dart';

class UpdateDive extends StatefulWidget {
  const UpdateDive({Key? key}) : super(key: key);

  @override
  State<UpdateDive> createState() => _UpdateDiveState();
}

class _UpdateDiveState extends State<UpdateDive> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController constrollerDiveSite = TextEditingController();
  final TextEditingController controllerStartDate = TextEditingController();
  final TextEditingController controllerStartHour = TextEditingController();
  final TextEditingController controllerDP = TextEditingController();
  final TextEditingController controllerBoat = TextEditingController();
  final TextEditingController controllerCaptainName = TextEditingController();
  final TextEditingController controllerNbPerson = TextEditingController();
  final TextEditingController controllerNbDivers = TextEditingController();
  final TextEditingController controllerInstruction = TextEditingController();
  bool isIntialized = false;

  final IsarService isarService = IsarService();

  @override
  Widget build(BuildContext context) {
    final dive = ModalRoute.of(context)!.settings.arguments as Dive;
    constrollerDiveSite.text = dive.divingSite;
    if (!isIntialized) {
      controllerStartDate.text =
          DateFormat('dd/MM/yyyy').format(dive.dateDepart);
      controllerStartHour.text = DateFormat("HH:mm").format(dive.dateDepart);
      controllerDP.text = dive.dp;
      controllerBoat.text = dive.boat;
      controllerCaptainName.text = dive.captain;
      controllerNbPerson.text = dive.nbPeople.toString();
      controllerNbDivers.text = dive.nbDiver.toString();
      isIntialized = true;
    }

    return Scaffold(
      appBar: CustoAppBar("Modification de la ${dive.title}"),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Le champs est obligatoire';
                                  }
                                  return null;
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
                              TextFormField(
                                controller: controllerDP,
                                decoration: const InputDecoration(
                                  labelText: 'Nom du DP',
                                ),
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
                                  validator: (value) {
                                    if (value != null &&
                                        int.parse(value) >
                                            int.parse(controllerNbPerson.text)) {
                                      return 'Le nombre de plongeurs est plus élevé que le nombre de personne sur le bateau';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      controller: controllerInstruction,
                      decoration:
                          const InputDecoration(labelText: 'Instruction du DP'),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      //definition de la date de départ
                      int year =
                          int.parse(controllerStartDate.text.substring(6, 10));
                      int month =
                          int.parse(controllerStartDate.text.substring(3, 5));
                      int day =
                          int.parse(controllerStartDate.text.substring(0, 2));
                      DateTime date = DateTime(year, month, day);

                      if (controllerStartHour.text.isNotEmpty) {
                        int hour =
                            int.parse(controllerStartHour.text.substring(0, 2));
                        int minute =
                            int.parse(controllerStartHour.text.substring(3, 5));
                        date = date.add(Duration(hours: hour, minutes: minute));
                      }
                      Dive updateDive = Dive()
                        ..id = dive.id
                        ..title = dive.title
                        ..divingSite = constrollerDiveSite.text
                        ..dateDepart = date
                        ..dp = controllerDP.text
                        ..boat = controllerBoat.text
                        ..captain = controllerCaptainName.text
                        ..nbPeople = int.parse(controllerNbPerson.text)
                        ..nbDiver = int.parse(controllerNbDivers.text)
                        ..instructionDp = controllerInstruction.text
                        ..weekend.value = dive.weekend.value;

                      bool isUpdate = await isarService.updateDive(updateDive);
                      if (isUpdate == true) {
                        Weekend? weekend = await isarService
                            .getWeekendByTitle(dive.weekend.value!.title);
                        if (weekend != null) {
                          Navigator.pushNamed(context, "/weekendDetail",
                              arguments: weekend);
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                            'Une erreur c\'est produite lors de la mise à jour',
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
