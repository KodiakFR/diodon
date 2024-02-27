// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/entities/weekend.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/participants_bloc.dart';

class AddParticipants extends StatefulWidget {
  const AddParticipants({super.key});

  @override
  State<AddParticipants> createState() => _AddParticipantsState();
}

class _AddParticipantsState extends State<AddParticipants> {
  final IsarService isarService = IsarService();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerFirstName = TextEditingController();
  String selectValueType = "Plongeur";
  String selectValueLevel = "";
  List<DropdownMenuItem<String>> typeItems = [
    const DropdownMenuItem(
      value: "Plongeur",
      child: Text("Plongeur"),
    ),
    const DropdownMenuItem(
      value: "Encadrant",
      child: Text("Encadrant"),
    ),
    const DropdownMenuItem(
      value: "Accompagnant Adulte",
      child: Text("Accompagnant Adulte"),
    ),
    const DropdownMenuItem(
      value: "Accompagnant 5-16 ans",
      child: Text("Accompagnant 5-16 ans"),
    ),
    const DropdownMenuItem(
      value: "Accompagnant < 5 ans",
      child: Text("Accompagnant < 5 ans"),
    ),
  ];

  List<DropdownMenuItem<String>> levelItems = [
    const DropdownMenuItem(
      value: "",
      child: Text(""),
    ),
    const DropdownMenuItem(
      value: "Bapt",
      child: Text("Bapt"),
    ),
    const DropdownMenuItem(
      value: "N1",
      child: Text("N1"),
    ),
    const DropdownMenuItem(
      value: "N2",
      child: Text("N2"),
    ),
    const DropdownMenuItem(
      value: "N3",
      child: Text("N3"),
    ),
    const DropdownMenuItem(
      value: "N4",
      child: Text("N4"),
    ),
    const DropdownMenuItem(
      value: "PpN1",
      child: Text("PpN1"),
    ),
    const DropdownMenuItem(
      value: "PpN2",
      child: Text("PpN2"),
    ),
    const DropdownMenuItem(
      value: "PpN3",
      child: Text("PpN3"),
    ),
    const DropdownMenuItem(
      value: "PpN4",
      child: Text("PpN4"),
    ),
    const DropdownMenuItem(
      value: "Nitrox",
      child: Text("Nitrox"),
    ),
    const DropdownMenuItem(
      value: "Nitrox-C",
      child: Text("Nitrox-C"),
    ),
    const DropdownMenuItem(
      value: "Rifap",
      child: Text("Rifap"),
    ),
    const DropdownMenuItem(
      value: "Initiateur",
      child: Text("Initiateur"),
    ),
    const DropdownMenuItem(
      value: "MF1",
      child: Text("MF1"),
    ),
    const DropdownMenuItem(
      value: "MF2",
      child: Text("MF2"),
    ),
    const DropdownMenuItem(
      value: "E4",
      child: Text("E4"),
    ),
    const DropdownMenuItem(
      value: "E3",
      child: Text("E3"),
    ),
    const DropdownMenuItem(
      value: "E2",
      child: Text("E2"),
    ),
    const DropdownMenuItem(
      value: "E1",
      child: Text("E1"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final weekend = ModalRoute.of(context)!.settings.arguments as Weekend;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text(
            "Participants du ${weekend.title}",
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.home, size: 40),
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, "/homePage", (route) => false),
            ),
          ]),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height / 1.3),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: BlocBuilder<ParticipantsBloc, List<Participant>>(
                      builder: (context, state) {
                        return FutureBuilder(
                          future: isarService
                              .getParticipantsFromWeekend(weekend.id!),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            if (snapshot.hasData) {
                              context
                                  .read<ParticipantsBloc>()
                                  .initParticipants(snapshot.data!);
                              if (state.isEmpty) {
                                return const Center(
                                    child: Text(
                                        'Aucun Parcipant n\'est enregistré pour ce week-end'));
                              }
                              return _displayParticipants(state, weekend);
                            }
                            return const CircularProgressIndicator();
                          },
                        );
                      },
                    )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _displayPopAddParticipants(context, weekend);
                  },
                  child: const Text("Ajout de participants"),
                ),
                const SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () async {
                    Weekend? weekendUpdate =
                        await isarService.getWeekendByTitle(weekend.title);
                    if (weekendUpdate != null) {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/weekendDetail",
                          arguments: weekendUpdate,
                          (route) => false);
                    }
                  },
                  child: const Text("Valider"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _displayParticipants(List<Participant> participants, Weekend weekend) {
    participants.sort(
      (a, b) => a.sort!.compareTo(b.sort!),
    );
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text("Nom"),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("Prénom"),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("Niveau"),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("Aptitude"),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("Type"),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text("Supprimer"),
          ),
        ),
      ],
      rows: participants
          .map(
            (participant) => DataRow(
              cells: [
                DataCell(Text(participant.name ?? '')),
                DataCell(Text(participant.firstName ?? '')),
                DataCell(Text(participant.diveLevel ?? '')),
                DataCell(Text(participant.aptitude ?? '')),
                DataCell(Text(participant.type ?? '')),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await context
                            .read<ParticipantsBloc>()
                            .removeParticipant(participant, weekend);
                      },
                      icon: const Icon(Icons.remove, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () async {
                        await _displayPopAddManuel(
                            context, weekend, participant);
                      },
                      icon: const Icon(Icons.edit, color: Colors.black),
                    )
                  ],
                ))
              ],
            ),
          )
          .toList(),
    );
  }

  Future<void> _displayPopAddParticipants(
      BuildContext context, Weekend weekend) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Ajout de participants',
                textAlign: TextAlign.center,
              ),
              actions: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Importer depuis un CSV"),
                        ElevatedButton(
                          onPressed: () async {
                            await _pickAndReadCSV(weekend);
                          },
                          child: const Text('Import'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Ajout manuel"),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            await _displayPopAddManuel(context, weekend, null);
                          },
                          child: const Text('Ajouter'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Annuler'))
                  ],
                )
              ],
            ));
  }

  Future<void> _displayPopAddManuel(
      BuildContext context, Weekend weekend, Participant? participant) async {
    _controllerFirstName.clear();
    _controllerName.clear();
    selectValueLevel = "";
    selectValueType = "Plongeur";
    if (participant != null) {
      if (participant.firstName != null) {
        _controllerFirstName.text = participant.firstName!;
      }
      if (participant.name != null) {
        _controllerName.text = participant.name!;
      }
      if (participant.diveLevel != null) {
        selectValueLevel = participant.diveLevel!;
      }
      if (participant.type != null && participant.type != "") {
        selectValueType = participant.type!;
      }
    }
    double widthForm = MediaQuery.of(context).size.width / 2.8;
    double heightForm = MediaQuery.of(context).size.height / 8.5;
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              scrollable: true,
              title: const Text(
                "Ajouter un participant",
                textAlign: TextAlign.center,
              ),
              actions: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widthForm,
                            height: heightForm,
                            child: TextFormField(
                              controller: _controllerName,
                              decoration:
                                  const InputDecoration(labelText: 'Nom'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le champs est obligatoire';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: widthForm,
                            height: heightForm,
                            child: TextFormField(
                              controller: _controllerFirstName,
                              decoration:
                                  const InputDecoration(labelText: 'Prénom'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Le champs est obligatoire';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widthForm,
                            height: heightForm,
                            child: DropdownButtonFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Type'),
                              value: selectValueType,
                              icon: const Icon(Icons.arrow_downward),
                              items: typeItems,
                              onChanged: (String? value) {
                                setState(() {
                                  selectValueType = value!;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: widthForm,
                            height: 100,
                            child: DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  labelText: "Niveau de plongée"),
                              value: selectValueLevel,
                              icon: const Icon(Icons.arrow_downward),
                              items: levelItems,
                              onChanged: (String? value) {
                                setState(() {
                                  selectValueLevel = value!;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text(
                                participant == null ? 'Ajouter' : 'Modifier'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                String? aptitude =
                                    _defineAptitude(selectValueLevel);
                                if (participant == null) {
                                  Participant newParticipant = Participant()
                                    ..firstName = _controllerFirstName.text
                                    ..name = _controllerName.text.toUpperCase()
                                    ..type = selectValueType
                                    ..diveLevel = selectValueLevel
                                    ..aptitude = aptitude
                                    ..selected = false
                                    ..sort = _difineSort(selectValueLevel)
                                    ..weekends.add(weekend);

                                  bool isSaved = await context
                                      .read<ParticipantsBloc>()
                                      .addParticipant(newParticipant, weekend);
                                  if (!isSaved) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        'Le participant est déjà dans la liste',
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                        'Le participant a bien été ajouté',
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Colors.green,
                                    ));
                                  }
                                } else {
                                  Participant newParticipant = Participant()
                                    ..id = participant.id
                                    ..firstName = _controllerFirstName.text
                                    ..name = _controllerName.text.toUpperCase()
                                    ..type = selectValueType
                                    ..diveLevel = selectValueLevel
                                    ..aptitude = aptitude
                                    ..selected = false
                                    ..sort = _difineSort(selectValueLevel)
                                    ..weekends.add(weekend);
                                  await context
                                      .read<ParticipantsBloc>()
                                      .updateParticipant(
                                          newParticipant, weekend);
                                }
                                Navigator.pop(context);
                              }
                            },
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Annuler'))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ));
  }

  _pickAndReadCSV(Weekend weekend) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom, allowedExtensions: ['csv'], withData: true);

      if (result != null) {
        //  analyser le CSV en utilisant la bibliothèque CSV
        String csvString = utf8.decode(result.files.single.bytes!);

        final List<List<dynamic>> csvDataList =
            const CsvToListConverter().convert(csvString);
        for (var i = 1; i < csvDataList.length; i++) {
          List<String> participantString = [];
          String temp = '';
          for (var j = 0; j < csvDataList[i].length; j++) {
            if (csvDataList[i][j].toString() != "") {
              temp = "$temp${csvDataList[i][j].toString()};";
            } else {
              temp = "$temp ;";
            }
          }
          participantString = temp.split(';');
          Participant participant = Participant()
            ..name = participantString[5]
            ..firstName = participantString[4]
            ..diveLevel = participantString[19]
            ..type = participantString[16]
            ..aptitude = _defineAptitude(participantString[19])
            ..selected = false
            ..sort = _difineSort(participantString[19])
            ..weekends.add(weekend);
          if (participant.name != "" && participant.name != "NOM") {
            await context
                .read<ParticipantsBloc>()
                .addParticipant(participant, weekend);
          }
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Les participants ont bien été ajouté',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ));
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Erreur lors de la sélection et de la lecture du fichier CSV',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.red,
      ));
      return null;
    }
  }

  String? _defineAptitude(String diveLevel) {
    String? aptitude;
    switch (diveLevel) {
      case "":
        aptitude = "";
        break;
      case "Bapt":
        aptitude = "";
        break;
      case "N1":
        aptitude = "PE20";
        break;
      case "N2":
        aptitude = "PE40";
        break;
      case "N3":
        aptitude = "PA60";
        break;
      case "N4":
        aptitude = "E2";
        break;
      case "PpN1":
        aptitude = "PE20";
        break;
      case "PpN2":
        aptitude = "PE20";
        break;
      case "PpN3":
        aptitude = "PE40";
        break;
      case "PpN4":
        aptitude = "PE40";
        break;
      case "MF1":
        aptitude = "E3";
        break;
      case "MF2":
        aptitude = "E4";
        break;
      default:
        aptitude = "";
    }
    return aptitude;
  }

  String getNameCSV(String nameConcatParticipant) {
    List<String> nameSplitParticipant = nameConcatParticipant.split(" ");
    String name = "";
    if (nameSplitParticipant.length > 1) {
      for (var i = 0; i < nameSplitParticipant.length - 1; i++) {
        name = "$name ${nameSplitParticipant[i]}";
      }
      return name;
    } else {
      return nameSplitParticipant[1];
    }
  }

  String getFirstNameCSV(String nameConcatParticipant) {
    List<String> nameSplitParticipant = nameConcatParticipant.split(" ");
    return nameSplitParticipant.last;
  }

  int _difineSort(String diveLevel) {
    int sort;
    switch (diveLevel) {
      case "E4":
        sort = 1;
        break;
      case "MF2":
        sort = 1;
        break;
      case "MF1":
        sort = 2;
        break;
      case "E3":
        sort = 2;
        break;
      case "E2":
        sort = 3;
        break;
      case "N4":
        sort = 4;
        break;
      case "E1":
        sort = 5;
        break;
      case "PpN4":
        sort = 6;
        break;
      case "PpN3":
        sort = 7;
        break;
      case "PpN2":
        sort = 8;
        break;
      case "PpN1":
        sort = 9;
        break;
      case "Bapt":
        sort = 10;
        break;
      case "N1":
        sort = 11;
        break;
      case "N2":
        sort = 12;
        break;
      case "N3":
        sort = 13;
        break;

      default:
        sort = 14;
    }
    return sort;
  }
}
