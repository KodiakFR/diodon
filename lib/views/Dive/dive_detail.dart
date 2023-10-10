// ignore_for_file: use_build_context_synchronously

import 'package:diodon/entities/dive_group.dart';
import 'package:diodon/entities/participant.dart';
import 'package:diodon/services/isar_service.dart';
import 'package:flutter/material.dart';

import '../../entities/dive.dart';


class DiveDetail extends StatefulWidget {
  const DiveDetail({Key? key}) : super(key: key);

  @override
  State<DiveDetail> createState() => _DiveDetailState();
}

class _DiveDetailState extends State<DiveDetail> {
  final List<Participant> _participantsSelected = [];

  @override

  Widget build(BuildContext context) {
    final dive = ModalRoute.of(context)!.settings.arguments as Dive;
    final IsarService isarService = IsarService();
 

    return Scaffold(
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
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: _recapDive(dive, context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  'Gestion des palanquées',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        FutureBuilder(
                          future: isarService.getAllDiverForDive(dive),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            if (snapshot.hasData) {
                              final List<Participant> participants =
                                  snapshot.data!;

                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.7,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                              selected: _participantsSelected.contains(participant),
                                              onSelectChanged: (isSelect) {
                                                setState(() {
                                                  final isAdding =
                                                      isSelect != null &&
                                                          isSelect;
                                                  isAdding
                                                      ? _participantsSelected
                                                          .add(participant)
                                                      : _participantsSelected
                                                          .remove(participant);
                                                  
                                                });
                                              },
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
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SingleChildScrollView(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 1.7,
                            child: FutureBuilder(
                              future: isarService.getAllDiveGroupForDive(dive),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                if (snapshot.hasData) {
                                  List<DiveGroup> dive_groups = snapshot.data;
                                  if (dive_groups.isEmpty) {
                                    return const Center(
                                      child: Text(
                                          'Aucune palanquée n\'a été créée'),
                                    );
                                  }
                                  return ListView.builder(
                                    itemCount: dive_groups.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Icon iconStandAlone =
                                          const Icon(Icons.check_box);
                                      Icon iconSupervised =
                                          const Icon(Icons.check_box);
                                      if (dive_groups[index].standAlone ==
                                              false ||
                                          dive_groups[index].standAlone ==
                                              null) {
                                        iconStandAlone = const Icon(
                                            Icons.check_box_outline_blank);
                                      }
                                      if (dive_groups[index].supervised ==
                                              false ||
                                          dive_groups[index].supervised ==
                                              null) {
                                        iconSupervised = const Icon(
                                            Icons.check_box_outline_blank);
                                      }
                                      return ExpansionTile(
                                        title: Text(dive_groups[index].title!),
                                        children: [
                                          ExpansionTile(
                                            title: const Text(
                                                "Paramètres de plongée"),
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Autonome: '),
                                                            iconStandAlone
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Row(
                                                          children: [
                                                            const Text(
                                                                'Encadrée: '),
                                                            iconSupervised
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            'Heure Imm: ${dive_groups[index].hourImmersion}'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            'Heure Sortie: ${dive_groups[index].riseHour}'),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child:
                                                            Text('Consigne DP'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            'Prof: ${dive_groups[index].dpDeep}'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            'Temps: ${dive_groups[index].dpTime}'),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10),
                                                        child: Text('Réalisé'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            'Prof: ${dive_groups[index].realDeep}'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            'Temps: ${dive_groups[index].realTime}'),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Text(
                                                            'Paliers: ${dive_groups[index].divingStop}'),
                                                      ),
                                                    ],
                                                  )
                                                ],
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
                                            ],
                                            rows: dive_groups[index]
                                                .participants
                                                .map(
                                                  (participant) => DataRow(
                                                    cells: [
                                                      DataCell(Text(participant
                                                              .firstName ??
                                                          '')),
                                                      DataCell(Text(
                                                          participant.name ??
                                                              '')),
                                                      DataCell(Text(participant
                                                              .diveLevel ??
                                                          '')),
                                                      DataCell(Text(participant
                                                              .aptitude ??
                                                          '')),
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
                                return const Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              List<DiveGroup> dive_group = await isarService
                                  .getAllDiveGroupForDive(dive);
                              int numberDiveGroup = dive_group.length + 1;
                              DiveGroup diveGroup = DiveGroup()
                                ..dive.value = dive
                                ..title = "palanquée $numberDiveGroup"
                                ..divingStop = ""
                                ..dpDeep = ""
                                ..dpTime = ""
                                ..hourImmersion = null
                                ..realDeep = ""
                                ..realTime = ""
                                ..riseHour = null
                                ..standAlone = false
                                ..supervised = false;

                              bool isSaved = await isarService.saveDiveGroup(
                                  dive, diveGroup);
                              if (isSaved == true) {
                                Navigator.pushReplacementNamed(
                                    context, arguments: dive, "/diveDetail");
                              }
                            },
                            child: const Text("Ajouter une palanquée"))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
              'Heure de départ: ${dive.dateDepart.hour}:${dive.dateDepart.minute}',
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
}
