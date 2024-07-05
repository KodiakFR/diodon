// ignore_for_file: use_build_context_synchronously

import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/dives_detail_bloc.dart';
import '../../entities/dive.dart';
import '../Widget/app_bar_custo.dart';

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
      appBar: CustoAppBar(dive.title),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Gestion des palanquées',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: Row(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _displayGroupDiver(BuildContext context, Dive dive) {
    return BlocBuilder<DiveDetailBloc, DiveDetailModel>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: FutureBuilder(
                      future: isarService.getAllDiveGroupForDive(dive),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        if (snapshot.hasData) {
                          context
                              .read<DiveDetailBloc>()
                              .initDiverGroup(snapshot.data);
                          if (state.divegroups.isEmpty) {
                            return const Center(
                              child: Text('Aucune palanquée n\'a été créée'),
                            );
                          }
                          return ListView.builder(
                            itemCount: state.divegroups.length,
                            itemBuilder: (BuildContext context, int index) {
                              List<Participant> particiapants =
                                  state.divegroups[index].participants.toList();
                              particiapants.sort(
                                (a, b) => a.sort!.compareTo(b.sort!),
                              );
                              state.divegroups[index].participants.clear();
                              for (var participant in particiapants) {
                                state.divegroups[index].participants
                                    .add(participant);
                              }
                              Icon iconStandAlone = const Icon(Icons.check_box);
                              Icon iconSupervised = const Icon(Icons.check_box);
                              if (state.divegroups[index].standAlone == false ||
                                  state.divegroups[index].standAlone == null) {
                                iconStandAlone =
                                    const Icon(Icons.check_box_outline_blank);
                              }
                              if (state.divegroups[index].supervised == false ||
                                  state.divegroups[index].supervised == null) {
                                iconSupervised =
                                    const Icon(Icons.check_box_outline_blank);
                              }
                              return ExpansionTile(
                                initiallyExpanded: true,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(state.divegroups[index].title!),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              List<Participant> particiapants =
                                                  await isarService
                                                      .getParticipantsSelected(
                                                          dive);
                                              for (var participant
                                                  in particiapants) {
                                                state.divegroups[index]
                                                    .participants
                                                    .add(participant);
                                                state.divegroups
                                                    .elementAt(index)
                                                    .participants
                                                    .add(participant);
                                                participant.selected = false;
                                                context
                                                    .read<DiveDetailBloc>()
                                                    .updateParticipant(
                                                        participant);
                                              }
                                              context
                                                  .read<DiveDetailBloc>()
                                                  .updateDiveGroup(
                                                      state.divegroups[index]);
                                            },
                                            icon: const Icon(
                                                Icons.group_add_sharp)),
                                        IconButton(
                                            onPressed: () async {
                                              bool delete = false;
                                              delete = await context
                                                  .read<DiveDetailBloc>()
                                                  .deleteDiveGroup(
                                                      state.divegroups[index],
                                                      dive);
                                              if (delete == false) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text(
                                                    'Veuillez supprimer tous les participants de la palanquée avant la suppression',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ));
                                              }
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                                children: [
                                  ExpansionTile(
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Paramètres de plongée"),
                                        IconButton(
                                          icon: const Icon(Icons.create),
                                          onPressed: () {
                                            _displayPopParameter(
                                                dive,
                                                state.divegroups[index],
                                                context);
                                          },
                                        )
                                      ],
                                    ),
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Column(
                                          children: [
                                            Wrap(
                                              spacing: 20,
                                              alignment: WrapAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Wrap(
                                                    children: [
                                                      const Text('Autonome: '),
                                                      iconStandAlone
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Wrap(
                                                    children: [
                                                      const Text('Encadrée: '),
                                                      iconSupervised
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                      'Heure Imm: ${DateFormat.Hm().format(state.divegroups[index].hourImmersion!)}'),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                      'Heure Sortie: ${DateFormat.Hm().format(state.divegroups[index].riseHour!)}'),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Text(
                                                        'Consigne DP',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                        'Profondeur: ${state.divegroups[index].dpDeep} m'),
                                                    Text(
                                                        'Temps: ${state.divegroups[index].dpTime} min'),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10, top: 10),
                                                      child: Text(
                                                        'Réalisé',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Text(
                                                        'Profondeur: ${state.divegroups[index].realDeep} m'),
                                                    Text(
                                                        'Temps: ${state.divegroups[index].realTime} min'),
                                                    Text(
                                                        'Paliers: ${state.divegroups[index].divingStop}'),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: DataTable(
                                        columnSpacing:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        columns: const <DataColumn>[
                                          DataColumn(
                                            label: Text("Prénom"),
                                          ),
                                          DataColumn(
                                            label: Text("Nom"),
                                          ),
                                          DataColumn(
                                            label: Text("Niveau"),
                                          ),
                                          DataColumn(
                                            label: Text("Aptitude"),
                                          ),
                                          DataColumn(
                                            label: Text("Action"),
                                          ),
                                        ],
                                        rows: state
                                            .divegroups[index].participants
                                            .map(
                                              (participant) => DataRow(
                                                color:
                                                    MaterialStateProperty.all(
                                                        _colorDataCell(
                                                            participant)),
                                                cells: [
                                                  DataCell(Text(
                                                      participant.firstName ??
                                                          '')),
                                                  DataCell(Text(
                                                      participant.name ?? '')),
                                                  DataCell(Text(
                                                      participant.diveLevel ??
                                                          '')),
                                                  DataCell(Text(
                                                      participant.aptitude ??
                                                          '')),
                                                  DataCell(Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () async {
                                                          await context
                                                              .read<
                                                                  DiveDetailBloc>()
                                                              .removeParticipantsInGroupDive(
                                                                  participant,
                                                                  state.divegroups[
                                                                      index]);

                                                          await context
                                                              .read<
                                                                  DiveDetailBloc>()
                                                              .updateParticipant(
                                                                  participant);
                                                        },
                                                        icon: const Icon(
                                                            Icons
                                                                .remove_circle_rounded,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  )),
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    )),
              ),
              ElevatedButton(
                  onPressed: () async {
                    await context.read<DiveDetailBloc>().newDiveGroup(dive);
                  },
                  child: const Text("Ajouter une palanquée"))
            ],
          ),
        );
      },
    );
  }

  Widget _displayDiverList(Dive dive) {
    return BlocBuilder<DiveDetailBloc, DiveDetailModel>(
      builder: (context, state) {
        return FutureBuilder(
          future: isarService.getAllDiverForDive(dive),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              context.read<DiveDetailBloc>().initDiver(snapshot.data!);
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        //horizontalMargin: 10,
                        columnSpacing: MediaQuery.of(context).size.width / 30,
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
                        rows: state.divers
                            .map(
                              (Participant participant) => DataRow(
                                color: MaterialStateProperty.all(
                                    _colorDataCell(participant)),
                                selected: participant.selected!,
                                onSelectChanged: (isSelect) async {
                                  bool isInGroupDive = await context
                                      .read<DiveDetailBloc>()
                                      .isInDiveGroup(dive, participant);
                                  setState(() {
                                    if (isInGroupDive == false) {
                                      participant.selected = isSelect;
                                      isarService
                                          .upDateParticipant(participant);
                                    }
                                  });
                                },
                                cells: [
                                  DataCell(Text(participant.firstName ?? '',
                                      style: TextStyle(
                                          decoration: state.divegroups.any(
                                                  (element) => element
                                                      .participants
                                                      .contains(participant))
                                              ? TextDecoration.lineThrough
                                              : null))),
                                  DataCell(Container(
                                    alignment: Alignment.center,
                                    child: Text(participant.name ?? '',
                                        style: TextStyle(
                                            decoration: state.divegroups.any(
                                                    (element) => element
                                                        .participants
                                                        .contains(participant))
                                                ? TextDecoration.lineThrough
                                                : null)),
                                  )),
                                  DataCell(Text(participant.diveLevel ?? '',
                                      style: TextStyle(
                                          decoration: state.divegroups.any(
                                                  (element) => element
                                                      .participants
                                                      .contains(participant))
                                              ? TextDecoration.lineThrough
                                              : null))),
                                  DataCell(
                                    Text(
                                      participant.aptitude ?? '',
                                      style: TextStyle(
                                          decoration: state.divegroups.any(
                                                  (element) => element
                                                      .participants
                                                      .contains(participant))
                                              ? TextDecoration.lineThrough
                                              : null),
                                    ),
                                  ),
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
        );
      },
    );
  }

  Wrap _recapDive(Dive dive, BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 30,
      runSpacing: 10,
      children: [
        Text(
          'Date de départ: ${dive.dateDepart.day}/${dive.dateDepart.month}/${dive.dateDepart.year}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Heure de départ: ${DateFormat.Hm().format(dive.dateDepart)}',
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
         Text(
          'Instruction DP : ${dive.instructionDp}',
          style: Theme.of(context).textTheme.titleMedium,
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
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            children: [
                              Padding(
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
                                            var df = DateFormat("HH:mm");
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
                                            var df = DateFormat("HH:mm");
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
                              Padding(
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
                              Padding(
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
                                      dateStart = dateStart.add(Duration(
                                          hours: hour, minutes: minute));
                                    }
                                    if (controllerStartEnd.text.isNotEmpty) {
                                      int hour = int.parse(controllerStartEnd
                                          .text
                                          .substring(0, 2));
                                      int minute = int.parse(controllerStartEnd
                                          .text
                                          .substring(3, 5));
                                      dateEnd = dateEnd.add(Duration(
                                          hours: hour, minutes: minute));
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
                                  context
                                      .read<DiveDetailBloc>()
                                      .updateParamters(dive, diveGroup);
                                  Navigator.pop(context);
                                },
                                child: const Text('Valider')),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }));
        });
  }

  Color _colorDataCell(Participant participant) {
    switch (participant.diveLevel) {
      case "MF2":
        return Colors.red.shade900;
      case "MF1":
        return Colors.red.shade700;
      case "N4":
        return Colors.red.shade500;
      case "PpN4":
        return Colors.blue.shade900;
      case "PpN3":
        return Colors.blue.shade700;
      case "PpN2":
        return Colors.blue.shade500;
      case "Ppn1":
        return Colors.blue.shade300;
      case "Bapt":
        return Colors.blue.shade100;
      case "N3":
        return Colors.green.shade900;
      case "N2":
        return Colors.green.shade700;
      case "N1":
        return Colors.green.shade500;
      default:
        return Colors.grey;
    }
  }
}
