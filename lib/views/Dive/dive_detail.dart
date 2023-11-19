// ignore_for_file: use_build_context_synchronously

import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../entities/dive.dart';

final _formKey = GlobalKey<FormState>();
bool standAlone = false;
bool supervised = false;

class DiveDetail extends StatefulWidget {
  const DiveDetail({Key? key}) : super(key: key);

  @override
  State<DiveDetail> createState() => _DiveDetailState();
}

class _DiveDetailState extends State<DiveDetail> {
  final IsarService isarService = IsarService();
  final TextEditingController controllerStartHour = TextEditingController();
  final TextEditingController controllerStartEnd = TextEditingController();
  final TextEditingController controllerDeepMaxDP = TextEditingController();
  final TextEditingController controllerTimeMaxDP = TextEditingController();
  final TextEditingController controllerDeepMaxReal = TextEditingController();
  final TextEditingController controllerTimeMaxReal = TextEditingController();
  final TextEditingController controllerTimDecoStop = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dive = ModalRoute.of(context)!.settings.arguments as Dive;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          dive.title,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home, size: 40),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, "/homePage", (route) => false),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: _recapDive(dive, context),
              ),
              Text(
                'Gestion des palanquées',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: _displayDiverList(dive),
                  ),
                  Expanded(
                    flex: 5,
                    child: _displayGroupDiver(context, dive),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Column _displayGroupDiver(BuildContext context, Dive dive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.6,
            child: FutureBuilder(
              future: isarService.getAllDiveGroupForDive(dive),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.hasData) {
                  List<DiveGroup> dive_groups = snapshot.data;
                  if (dive_groups.isEmpty) {
                    return const Center(
                      child: Text('Aucune palanquée n\'a été créée'),
                    );
                  }
                  return ListView.builder(
                    itemCount: dive_groups.length,
                    itemBuilder: (BuildContext context, int index) {
                      Icon iconStandAlone = const Icon(Icons.check_box);
                      Icon iconSupervised = const Icon(Icons.check_box);
                      if (dive_groups[index].standAlone == false ||
                          dive_groups[index].standAlone == null) {
                        iconStandAlone =
                            const Icon(Icons.check_box_outline_blank);
                      }
                      if (dive_groups[index].supervised == false ||
                          dive_groups[index].supervised == null) {
                        iconSupervised =
                            const Icon(Icons.check_box_outline_blank);
                      }
                      return ExpansionTile(
                        initiallyExpanded: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(dive_groups[index].title!),
                            IconButton(
                                onPressed: () async {
                                  List<Participant> particiapants =
                                      await isarService
                                          .getParticipantsSelected(dive);
                                  for (var participant in particiapants) {
                                    dive_groups[index]
                                        .participants
                                        .add(participant);
                                    participant.selected = false;
                                    participant.isInDiveGroup = true;
                                    isarService.upDateParticipant(participant);
                                  }
                                  isarService
                                      .updateDiveGroupe(dive_groups[index]);
                                  Navigator.pushReplacementNamed(
                                      context, "/diveDetail",
                                      arguments: dive);
                                },
                                icon: const Icon(Icons.group_add_sharp))
                          ],
                        ),
                        children: [
                          ExpansionTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Paramètres de plongée"),
                                IconButton(
                                  icon: const Icon(Icons.create),
                                  onPressed: () {
                                    _displayPopParameter(
                                        dive, dive_groups[index], context);
                                  },
                                )
                              ],
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              const Text('Autonome: '),
                                              iconStandAlone
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Row(
                                            children: [
                                              const Text('Encadrée: '),
                                              iconSupervised
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                              'Heure Imm: ${DateFormat.Hm().format(dive_groups[index].hourImmersion!)}'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                              'Heure Sortie: ${DateFormat.Hm().format(dive_groups[index].riseHour!)}'),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(
                                                'Consigne DP',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                                'Profondeur: ${dive_groups[index].dpDeep} m'),
                                            Text(
                                                'Temps: ${dive_groups[index].dpTime} min'),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: 10, top: 10),
                                              child: Text(
                                                'Réalisé',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Text(
                                                'Profondeur: ${dive_groups[index].realDeep} m'),
                                            Text(
                                                'Temps: ${dive_groups[index].realTime} min'),
                                            Text(
                                                'Paliers: ${dive_groups[index].divingStop}'),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          DataTable(
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Expanded(
                                  child: Text("Prénom"),
                                ),
                              ),
                              DataColumn(
                                label: Expanded(
                                  child: Text("Nom"),
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
                                  child: Text("Action"),
                                ),
                              ),
                            ],
                            rows: dive_groups[index]
                                .participants
                                .map(
                                  (participant) => DataRow(
                                    cells: [
                                      DataCell(
                                          Text(participant.firstName ?? '')),
                                      DataCell(Text(participant.name ?? '')),
                                      DataCell(
                                          Text(participant.diveLevel ?? '')),
                                      DataCell(
                                          Text(participant.aptitude ?? '')),
                                      DataCell(Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await isarService
                                                  .removeParticipantsInGroupDive(
                                                      participant,
                                                      dive_groups[index]);
                                              participant.isInDiveGroup = false;
                                              await isarService
                                                  .upDateParticipant(
                                                      participant);
                                              Navigator.pushReplacementNamed(
                                                  context, "/diveDetail",
                                                  arguments: dive);
                                            },
                                            icon: const Icon(Icons.remove,
                                                color: Colors.red),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      );
                    },
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              List<DiveGroup> dive_group =
                  await isarService.getAllDiveGroupForDive(dive);
              int numberDiveGroup = dive_group.length + 1;
              DiveGroup diveGroup = DiveGroup()
                ..dive.value = dive
                ..title = "palanquée $numberDiveGroup"
                ..divingStop = ""
                ..dpDeep = ""
                ..dpTime = ""
                ..hourImmersion = DateTime(1970)
                ..realDeep = ""
                ..realTime = ""
                ..riseHour = DateTime(1970)
                ..standAlone = false
                ..supervised = false;

              bool isSaved = await isarService.saveDiveGroup(dive, diveGroup);
              if (isSaved == true) {
                Navigator.pushReplacementNamed(
                    context, arguments: dive, "/diveDetail");
              }
            },
            child: const Text("Ajouter une palanquée"))
      ],
    );
  }

  Column _displayDiverList(Dive dive) {
    return Column(
      children: [
        FutureBuilder(
          future: isarService.getAllDiverForDive(dive),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              final List<Participant> participants = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.6,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text("Prénom"),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text("Nom"),
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
                        ],
                        rows: participants
                            .map(
                              (Participant participant) => DataRow(
                                selected: participant.selected!,
                                onSelectChanged: (isSelect) {
                                  setState(() {
                                    if (participant.isInDiveGroup == false) {
                                      participant.selected = isSelect;
                                      isarService
                                          .upDateParticipant(participant);
                                    }
                                  });
                                },
                                cells: [
                                  DataCell(Text(participant.firstName ?? '',
                                      style: TextStyle(
                                          decoration: participant.isInDiveGroup!
                                              ? TextDecoration.lineThrough
                                              : null))),
                                  DataCell(Text(participant.name ?? '',
                                      style: TextStyle(
                                          decoration: participant.isInDiveGroup!
                                              ? TextDecoration.lineThrough
                                              : null))),
                                  DataCell(Text(participant.diveLevel ?? '',
                                      style: TextStyle(
                                          decoration: participant.isInDiveGroup!
                                              ? TextDecoration.lineThrough
                                              : null))),
                                  DataCell(Text(participant.aptitude ?? '',
                                      style: TextStyle(
                                          decoration: participant.isInDiveGroup!
                                              ? TextDecoration.lineThrough
                                              : null))),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  Wrap _recapDive(Dive dive, BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Date de départ: ${dive.dateDepart.day}/${dive.dateDepart.month}/${dive.dateDepart.year}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Heure de départ: ${DateFormat.Hm().format(dive.dateDepart!)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'DP : ${dive.dp}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Nombre de plongeurs : ${dive.nbDiver.toString()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Nom du navire : ${dive.boat}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Capitaine : ${dive.captain}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Site de plongée : ${dive.divingSite}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Nombre de personnes : ${dive.nbPeople.toString()}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        )
      ],
    );
  }

  _displayPopParameter(Dive dive, DiveGroup diveGroup, BuildContext context) {
    controllerStartHour.text = DateFormat.Hm().format(diveGroup.hourImmersion!);
    controllerStartEnd.text = DateFormat.Hm().format(diveGroup.riseHour!);
    if (diveGroup.dpDeep != null) {
      controllerDeepMaxDP.text = diveGroup.dpDeep!;
    }
    if (diveGroup.dpTime != null) {
      controllerTimeMaxDP.text = diveGroup.dpTime!;
    }
    if (diveGroup.realDeep != null) {
      controllerDeepMaxReal.text = diveGroup.realDeep!;
    }
    if (diveGroup.realTime != null) {
      controllerTimeMaxReal.text = diveGroup.realTime!;
    }
    if (diveGroup.divingStop != null) {
      controllerTimDecoStop.text = diveGroup.divingStop!;
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Paramètre de plongée'),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    const Text("Paramètres générales"),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        const Text("Plongée Autonomne"),
                                        Switch(
                                            value: diveGroup.standAlone!,
                                            onChanged: (bool value) {
                                              setState(() {
                                                diveGroup.standAlone = value;
                                                diveGroup.supervised = !value;
                                              });
                                            }),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text("Plongée Encadré"),
                                        Switch(
                                            value: diveGroup.supervised!,
                                            onChanged: (bool value) {
                                              setState(() {
                                                diveGroup.supervised = value;
                                                diveGroup.standAlone = !value;
                                              });
                                            }),
                                      ],
                                    ),
                                    TextFormField(
                                      controller: controllerStartHour,
                                      showCursor: true,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        icon:
                                            Icon(Icons.calendar_today_rounded),
                                        labelText: 'Heure d\'immersion',
                                      ),
                                      onTap: () async {
                                        TimeOfDay? pickedHour =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      alwaysUse24HourFormat:
                                                          true),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (pickedHour != null) {
                                          setState(() {
                                            var df = DateFormat("h:mm a");
                                            var dt = df.parse(
                                                pickedHour.format(context));
                                            controllerStartHour.text =
                                                DateFormat("HH:mm").format(dt);
                                          });
                                        }
                                      },
                                    ),
                                    TextFormField(
                                      controller: controllerStartEnd,
                                      showCursor: true,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        icon:
                                            Icon(Icons.calendar_today_rounded),
                                        labelText: 'Heure sortie',
                                      ),
                                      onTap: () async {
                                        TimeOfDay? pickedHour =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(context)
                                                  .copyWith(
                                                      alwaysUse24HourFormat:
                                                          true),
                                              child: child!,
                                            );
                                          },
                                        );
                                        if (pickedHour != null) {
                                          setState(() {
                                            var df = DateFormat("h:mm a");
                                            var dt = df.parse(
                                                pickedHour.format(context));
                                            controllerStartEnd.text =
                                                DateFormat("HH:mm").format(dt);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    const Text("Consigne du DP"),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: controllerDeepMaxDP,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Profondeur max'),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: controllerTimeMaxDP,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Temps max (min)'),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: [
                                    const Text("Réalisé"),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    TextFormField(
                                      controller: controllerDeepMaxReal,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Profondeur de plongée'),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: controllerTimeMaxReal,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          labelText: 'Temps de plongée (min)'),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      controller: controllerTimDecoStop,
                                      decoration: const InputDecoration(
                                          labelText: 'Palier'),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  DateTime dateStart = DateTime(1970);
                                  DateTime dateEnd = DateTime(1970);

                                  if (controllerStartHour.text.isNotEmpty) {
                                    int hour = int.parse(controllerStartHour
                                        .text
                                        .substring(0, 2));
                                    int minute = int.parse(controllerStartHour
                                        .text
                                        .substring(3, 5));
                                    dateStart = dateStart.add(
                                        Duration(hours: hour, minutes: minute));
                                  }
                                  if (controllerStartEnd.text.isNotEmpty) {
                                    int hour = int.parse(controllerStartEnd.text
                                        .substring(0, 2));
                                    int minute = int.parse(controllerStartEnd
                                        .text
                                        .substring(3, 5));
                                    dateEnd = dateEnd.add(
                                        Duration(hours: hour, minutes: minute));
                                  }
                                  diveGroup.hourImmersion = dateStart;
                                  diveGroup.riseHour = dateEnd;
                                  diveGroup.dpDeep = controllerDeepMaxDP.text;
                                  diveGroup.dpTime = controllerTimeMaxDP.text;
                                  diveGroup.realDeep =
                                      controllerDeepMaxReal.text;
                                  diveGroup.realTime =
                                      controllerTimeMaxReal.text;
                                  diveGroup.divingStop =
                                      controllerTimDecoStop.text;
                                }
                                bool isUpdate = await isarService
                                    .upDateDiveGroup(dive, diveGroup);
                                if (isUpdate == true) {
                                  Navigator.pushReplacementNamed(
                                      context, arguments: dive, "/diveDetail");
                                } else {
                                  print('Erreur de sauvegarde');
                                }
                              },
                              child: const Text('Valider')),
                        )
                      ],
                    ),
                  ),
                );
              }));
        });
  }
}
